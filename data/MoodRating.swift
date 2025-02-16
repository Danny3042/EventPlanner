//
//  MoodRating.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

enum MoodRating: String, CaseIterable, Identifiable, Codable {
    case happy = "Happy"
    case neutral = "Neutral"
    case sad = "Sad"
    case stressed = "Stressed"
    case relaxed = "Relaxed"
    
    var id: String { self.rawValue }
    
    var emoji: String {
        switch self {
        case .happy: return "😄"
        case .neutral: return "😐"
        case .sad : return "😔"
        case .stressed: return "😫"
        case .relaxed: return "😌"
        }
    }
    
    var description: String {
        switch self {
        case .happy: return "Happy"
        case .neutral: return "Neutral"
        case .sad: return "Sad"
        case .stressed: return "Stressed"
        case .relaxed: return "Relaxed"
        }
    }
}
