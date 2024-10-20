//
//  DayEntry.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

import Foundation

struct DayEntry: Identifiable {
    var id = UUID()
    var date: Date
    var moodRating: MoodRating
}
