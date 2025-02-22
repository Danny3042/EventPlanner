//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 22/02/2025.
//

import SwiftUI


struct StatisticsView: View {
    let meditationDuration: Int
    @State var userFeeling: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Statistics")
                    .font(.largeTitle)
                    .padding()

                Text("Time Meditating: \(meditationDuration) minutes")
                    .font(.headline)
                    .padding()

                Text("How do you feel after meditating?")
                    .font(.headline)
                    .padding()

                TextField("Enter your feelings here", text: $userFeeling)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()


                // Add other statistics here
            }
            .padding()
        }
    }
}

