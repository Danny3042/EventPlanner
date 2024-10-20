//
//  MoodInputViewModel.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

import SwiftUI

struct MoodInputModalView: View {
    @State var dayEntry: DayEntry
    var onSave: (DayEntry) -> Void
    var onCancel: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Mood for \(formattedDate(for: dayEntry.date))")
                    .font(.title2)
                
                Picker("Mood Rating", selection: $dayEntry.moodRating) {
                    ForEach(MoodRating.allCases) { mood in
                        Text(mood.description).tag(mood)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Spacer()

                HStack {
                    Button(action: onCancel) {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        onSave(dayEntry)
                    }) {
                        Text("Save")
                            .bold()
                    }
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Mood Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
