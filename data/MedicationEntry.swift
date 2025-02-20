//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import Foundation
import SwiftData
import RealityKit
import SwiftUICore


@Model
class Medication {
    var name: String
    var dateScanned: Date

    init(name: String, dateScanned: Date) {
        self.name = name
        self.dateScanned = dateScanned
    }
}

class MedicationStore {
    static let shared = MedicationStore()
    
    @Environment(\.modelContext) private var modelContext

    func save(medication: Medication) {
        modelContext.insert(medication)
        try? modelContext.save()
    }

    func fetchAllMedications() -> [Medication] {
        return (try? modelContext.fetch(FetchDescriptor<Medication>())) ?? []
    }
}
