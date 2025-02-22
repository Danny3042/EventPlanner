//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 22/02/2025.
//

import Foundation

struct Goal: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var targetDuration: Int
    var currentProgress: Int
}
