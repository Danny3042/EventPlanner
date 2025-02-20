//
//  MockData.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/10/2024.
//

import SwiftUI

let mockMoodEntries: [MoodEntry] = [
    MoodEntry(date: Date(), mood: "Happy"),
    MoodEntry(date: Date().addingTimeInterval(-86400), mood: "Neutral"),
    MoodEntry(date: Date().addingTimeInterval(-86400*2), mood: "Sad")
]

let mockRecommendations: [Recommendation] = [
    Recommendation(text: "Go for a walk"),
    Recommendation(text: "Log your mood every evening"),
    Recommendation(text: "Spend 10 minutes meditating")
]


