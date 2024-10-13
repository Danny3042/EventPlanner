//
//  MoodRating.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

enum MoodRating: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case neutral = "Neutral"
    case sad = "Sad"
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .happy: return "Happy"
        case .neutral: return "Neutral"
        case .sad: return "Sad"
        }
    }
}
