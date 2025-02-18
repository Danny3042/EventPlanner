//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 18/02/2025.
//

import Foundation
import SwiftData

@Model
class MeditationSession {
    var date: Date
    var duration: Int
    
    init(date: Date, duration: Int) {
        self.date = date
        self.duration = duration
        
    }
}
