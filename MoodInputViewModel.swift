//
//  MoodInputViewModel.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/10/2024.
//

import SwiftUI

class MoodInputViewModel: ObservableObject {
    @Published var weekEntries: [MoodEntry] = []
    
    init() {
        generateWeekEntries()
    }
    
    func generateWeekEntries() {
        let calendar = Calendar.current
        let today = Date()
        let startofWeek = calendar.dateInterval(of: .weekOfMonth, for: today)?.start ?? today
        
        weekEntries = (0..<7).map { dayOffset in
            let day = calendar.date(byAdding: .day, value: dayOffset, to: startofWeek) ?? today
            return MoodEntry(date: day, mood: "")
        }
    }
    
    func updateMood(for day: Date, mood: String) {
        if let index = weekEntries.firstIndex(where: {$0.date == day }) {
            weekEntries[index].mood = mood
        }
    }
}
