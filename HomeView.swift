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
            VStack(alignment:.leading, spacing: 20) {
                
                // section for Mood Entries
                Text("Recent Mood Entries")
                    .font(.headline)
                    .padding(.horizontal)
                
                // Display mood entries in card view
                ForEach(moodEntries) { entry in
                    MoodCardView(moodEntry: entry)
                        .padding(.horizontal)
                }
                
                //section for recommendation
                Text("Today's Recommendations")
                    .font(.headline)
                    .padding(.horizontal)
                
                // display recommendations in card view
                ForEach(recommendations) { recommendation in
                    RecommendationCardView(recommendation: recommendation)
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
}




