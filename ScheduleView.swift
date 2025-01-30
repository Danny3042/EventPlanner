import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DayEntry.date, order: .forward) private var weekEntries: [DayEntry]

    @State private var selectedDate: Date = Date()
    @State private var selectedEntry: DayEntry?
    @State private var showMoodInputModal: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Week view
                    weekCalendarView(selectedDate: $selectedDate, onDateSelected: selectOrCreateEntry)
                    
                    if let selectedEntry = selectedEntry {
                        MoodEntryCard(entry: selectedEntry)
                            .padding()
                    }
                    
                    Spacer()
                }
                .onAppear {
                    initializeWeekEntries()
                    selectOrCreateEntry(for: selectedDate)
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showMoodInputModal.toggle()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(Color.purple)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                    }
                }
            }
            .navigationTitle("Schedule")
            .sheet(isPresented: $showMoodInputModal) {
                MoodInputModalView(dayEntry: selectedEntry ?? DayEntry(date: Date(), moodRating: .neutral),
                                   onSave: saveMoodEntry,
                                   onCancel: { showMoodInputModal = false })
            }
        }
    }


    private func initializeWeekEntries() {
        let currentWeekDates = getWeek()
        for date in currentWeekDates {
            if !weekEntries.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                let newEntry = DayEntry(date: date, moodRating: .neutral)
                modelContext.insert(newEntry)
            }
        }
    }

    private func selectOrCreateEntry(for date: Date) {
        if let entry = weekEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            selectedEntry = entry
        } else {
            let newEntry = DayEntry(date: date, moodRating: .neutral)
            modelContext.insert(newEntry)
            selectedEntry = newEntry
        }
    }

    private func saveMoodEntry(entry: DayEntry) {
        if let index = weekEntries.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: entry.date) }) {
            weekEntries[index].moodRating = entry.moodRating
        } else {
            modelContext.insert(entry)
        }
        showMoodInputModal = false
    }

    private func getWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        let startOfWeek = calendar.date(from: components) ?? today
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    private func weekCalendarView(selectedDate: Binding<Date>, onDateSelected: @escaping (Date) -> Void) -> some View {
        let dates = getWeek()
        let calendar = Calendar.current

        return VStack {
            Text(getMonth(date: Date()))
                .font(.title)
                .padding(.bottom, 10)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(dates, id: \.self) { day in
                        VStack {
                            Text(getDayShort(date: day))
                                .font(.body)
                            Text("\(getDayNumber(date: day))")
                                .font(.body)
                        }
                        .frame(width: 45, height: 45)
                        .background(calendar.isDate(selectedDate.wrappedValue, inSameDayAs: day) ? Color.purple.opacity(0.5) : Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedDate.wrappedValue = day
                            onDateSelected(day)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func getMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter.string(from: date)
    }

    private func getDayShort(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }

    private func getDayNumber(date: Date) -> Int {
        return Calendar.current.component(.day, from: date)
    }
}
