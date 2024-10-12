//
//  models.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/10/2024.
//

import Foundation

struct MoodEntry: Identifiable {
    var id = UUID()
    var date: Date
    var mood: String
}

// Recommendation model
struct Recommendation: Identifiable {
    var id = UUID()
    var text: String
}
