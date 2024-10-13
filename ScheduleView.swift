//
//  ScheduleView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 17/05/2024.
//
import SwiftUI

struct ScheduleView: View {
    @State private var selectedDate: Date = Date() // Default to today's date
    @State private var moodRating: Double = 5.0
    @State private var sleepRating: Double = 7.0
    @State private var isShowingMoodInput = false
    
    // This will generate dates for the current week
    var currentWeekDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: today)?.start ?? today
        
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }
    
    let instructions = """
        1. Swipe left or right on a rating card to delete it.
        2. Click on a date to view or add ratings.
        3. Click on the floating action button to add a new rating.
    """
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Navigation Instructions
            Text("Navigation Instructions")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Text(instructions)
                .font(.caption)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // Today's Date and Weekly Selector
            Text("Today")
                .font(.headline)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Horizontal Days
            GeometryReader { geometry in
                HStack(spacing: 5) {
                    ForEach(currentWeekDates, id: \.self) { date in
                        DayView(date: date)
                            .onTapGesture {
                                // Select the day
                                selectedDate = date
                            }
                            .background(Calendar.current.isDate(selectedDate, inSameDayAs: date) ? Color.purple.opacity(0.5) : Color.gray.opacity(0.3)) // Highlight selected day
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity) // Make sure it fits within the screen
            }
            .frame(height: 70) // Fix height for the day row
            
            // Rating Card for Mood and Sleep
            VStack(alignment: .leading, spacing: 10) {
                Text("Sleep Rating: \(sleepRating, specifier: "%.1f")")
                Text("Mood Rating: \(moodRating, specifier: "%.1f")")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.purple.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
            
            // Floating Action Button
            Button(action: {
                // Show the mood input modal
                isShowingMoodInput = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.purple)
                    .cornerRadius(30)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $isShowingMoodInput) {
                MoodInputView(moodRating: $moodRating, sleepRating: $sleepRating) // Modal for mood input
            }
        }
    }
}

// Subview for each day
struct DayView: View {
    let date: Date
    
    var body: some View {
        VStack {
            // Display first 3 letters of the day (e.g., "Mon", "Tue")
            Text(dateFormatted(date: date, format: "EEE"))
                .font(.headline)
                .foregroundColor(.white)
            
            // Display numeric day (e.g., "10", "11")
            Text(dateFormatted(date: date, format: "d"))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(10)
        .aspectRatio(1.0, contentMode: .fit) // Maintain a square aspect ratio
        .background(Color.purple.opacity(0.6))
        .cornerRadius(10)
    }
    
    // Helper function to format date
    func dateFormatted(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}


#Preview {
    ScheduleView()
}
