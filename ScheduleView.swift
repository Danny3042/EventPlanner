import SwiftUI
import SwiftData

// Main Schedule View
struct ScheduleView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DayEntry.date, order: .forward) private var weekEntries: [DayEntry]

    @State private var selectedDate: Date = Date()
    @State private var selectedEntry: DayEntry?
    @State private var showMoodInputModal: Bool = false

    var body: some View {
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
                // Initialize entries for the current week if not done already
                let currentWeekDates = getWeek()
                for date in currentWeekDates {
                    if !weekEntries.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                        // Create and insert a new entry into the model context
                        let newEntry = DayEntry(date: date, moodRating: .neutral) // Default mood rating
                        modelContext.insert(newEntry) // Use the model context to insert the new entry
                    }
                }
                selectOrCreateEntry(for: selectedDate)
            }
            
            // Floating Action Button
            VStack {
                Spacer() // Align the button to the bottom
                HStack {
                    Spacer() // Align the button to the right
                    
                    // FAB Button
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
                    .padding(.bottom, 20) // Adjust bottom padding for spacing
                    .padding(.trailing, 20) // Adjust right padding for spacing
                }
            }
        }
        // Modal view
        .sheet(isPresented: $showMoodInputModal) {
            MoodInputModalView(dayEntry: selectedEntry ?? DayEntry(date: Date(), moodRating: .neutral), onSave: saveMoodEntry, onCancel: {
                showMoodInputModal = false
            })
        }
    }
    
    // Helper function to select or create an entry for a day
    private func selectOrCreateEntry(for date: Date) {
        if let entry = weekEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            selectedEntry = entry
        } else {
            // If entry does not exist, create a new one and select it
            let newEntry = DayEntry(date: date, moodRating: .neutral)
            modelContext.insert(newEntry) // Insert into the model context
            selectedEntry = newEntry
        }
    }
    
    // Function to save the mood entry from the modal
    private func saveMoodEntry(entry: DayEntry) {
        // Use model context to save updates to existing entries
        if let index = weekEntries.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: entry.date) }) {
            // Update the existing entry in the model context
            let existingEntry = weekEntries[index]
            existingEntry.moodRating = entry.moodRating // Assuming moodRating is a mutable property
        } else {
            // If the entry is new, insert it
            modelContext.insert(entry)
        }
        showMoodInputModal = false
    }

    // Helper function to get the week dates (Sunday to Saturday)
    func getWeek() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        
        // Find the start of the week (assuming Sunday is the first day of the week)
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        let startOfWeek = calendar.date(from: components) ?? today

        // Generate the 7 days of the current week
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }
    
    // Calendar view displaying the week
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }

    private func getDayShort(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }

    private func getDayNumber(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }
}

