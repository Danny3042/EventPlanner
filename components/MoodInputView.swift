//
//  MoodInputView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

import SwiftUI

struct MoodInputView: View {
    @Binding var moodRating: Double
    @Binding var sleepRating: Double
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add Mood & Sleep Ratings")
                    .font(.headline)
                    .padding()
                
                // Mood Rating Slider
                VStack(alignment: .leading) {
                    Text("Mood Rating")
                    Slider(value: $moodRating, in: 1...10, step: 1)
                    Text("Rating: \(moodRating, specifier: "%.0f")")
                }
                .padding()
                
                // Sleep Rating Slider
                VStack(alignment: .leading) {
                    Text("Sleep Rating")
                    Slider(value: $sleepRating, in: 1...10, step: 1)
                    Text("Rating: \(sleepRating, specifier: "%.0f")")
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Input Mood & Sleep")
            .navigationBarItems(
                leading: Button("Cancel") {
                    // Dismiss the modal when Cancel is tapped
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    // Dismiss the modal when Save is tapped
                    presentationMode.wrappedValue.dismiss()
                }
                .bold()
            )
        }
    }
}

