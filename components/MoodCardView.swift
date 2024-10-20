//
//  SwiftUIView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/10/2024.
//

import SwiftUI

struct MoodCardView: View {
    var moodEntry: MoodEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(moodEntry.mood)
                .font(.title)
                .fontWeight(.bold)
            
            Text(moodEntry.date, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


