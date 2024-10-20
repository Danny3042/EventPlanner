//
//  SwiftUIView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/10/2024.
//

import SwiftUI

struct RecommendationCardView: View {
    var recommendation: Recommendation
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommendation")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(recommendation.text)
                .font(.body)
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

