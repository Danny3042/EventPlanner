//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import Foundation
import SwiftData

@Model
class Medication {
    var name: String
    var dosage: String
    var pillsRemaining: Int
    var taken: Bool
    
    init(name: String, dosage: String, pillsRemaining: Int, taken: Bool = false) {
        self.name = name
        self.dosage = dosage
        self.pillsRemaining = pillsRemaining
        self.taken = taken
    }
}
