//
//  HomeView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/05/2024.
//

import SwiftUI

struct HomeView: View {
    var moodEntries: [MoodEntry]
    var recommendations: [Recommendation]

    var body: some View {
        ScrollView {
            NavigationView {
                VStack(alignment:.leading, spacing: 20) {
                    
                    Text("Welcome to Mindfulness App")
                        .font(.title)
                        .padding()
                    
                    NavigationLink(destination: ARViewRepresentable()) {
                        Text("Tap here to access AR")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .navigationTitle("Home")
                    .padding(.top)
                }
            }
        }
    }
}




