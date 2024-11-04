//
//  DayEntry.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

import Foundation
import SwiftData

@Model
class DayEntry {
    @Attribute var id: UUID  = UUID()// Define as primary key
    var date: Date // Date of the entry
    var moodRating: MoodRating // Mood rating for the entry

    // Initializer
    init(id: UUID = UUID(), date: Date, moodRating: MoodRating) {
        self.id = id
        self.date = date
        self.moodRating = moodRating
    }
}


