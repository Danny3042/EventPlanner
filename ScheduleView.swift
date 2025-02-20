import SwiftUI
import SwiftData
import Combine

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
                    // DatePicker view
                    DatePicker(
                        "Select a date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .onReceive(Just(selectedDate)) { newDate in
                        selectOrCreateEntry(for: newDate)
                    }

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
                        FloatingActionButton {
                            showMoodInputModal.toggle()
                        }
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                    }
                }
            }
            .navigationTitle("Schedule")
            .sheet(isPresented: $showMoodInputModal) {
                MoodInputModalView(
                    dayEntry: selectedEntry ?? DayEntry(date: Date(), moodRating: .neutral),
                    onSave: saveMoodEntry,
                    onCancel: { showMoodInputModal = false }
                )
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
        try? modelContext.save()
    }

    private func selectOrCreateEntry(for date: Date) {
        if let entry = weekEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            selectedEntry = entry
        } else {
            let newEntry = DayEntry(date: date, moodRating: .neutral)
            modelContext.insert(newEntry)
            selectedEntry = newEntry
        }
        try? modelContext.save()
    }

    private func saveMoodEntry(entry: DayEntry) {
        if let index = weekEntries.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: entry.date) }) {
            weekEntries[index].moodRating = entry.moodRating
        } else {
            modelContext.insert(entry)
        }
        try? modelContext.save()
        showMoodInputModal = false
    }

    private func getWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        guard let startOfWeek = calendar.date(from: components) else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
}
