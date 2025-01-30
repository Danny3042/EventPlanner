//
//  MoodEntryCard.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 20/10/2024.
//

import SwiftUI

struct MoodEntryCard: View {
        var entry: DayEntry

        var body: some View {
            VStack {
                Text("Mood for \(formattedDate(entry.date))")
                    .font(.headline)
                Text("\(entry.moodRating == .happy ? "😊" : entry.moodRating == .neutral ? "😐" : "😢")") // Emoji based on mood rating
                    .font(.largeTitle)
                // Additional mood details can be added here
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        
        private func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
    }
