//
//  HomeViewModel.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/05/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var moodEntries: [MoodEntry] = [
        MoodEntry(date: Date(), mood: "😊 Happy"),
        MoodEntry(date: Date().addingTimeInterval(-86400), mood: "😐 Neutral"),
        MoodEntry(date: Date().addingTimeInterval(-86400 * 2), mood: "😔 Sad")
    ]
    
    @Published var recommendations: [Recommendation] = [
        Recommendation(text: "Take 5 deep breaths to relax."),
        Recommendation(text: "Log your mood every evening."),
        Recommendation(text: "Spend 10 minutes meditating today.")
    ]
}
