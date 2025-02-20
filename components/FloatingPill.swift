//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import RealityKit
import SwiftUI

class ARFloatingPill {
    static func createFloatingPill(medicationName: String, dosage: String, color: UIColor = .red, radius: Float = 0.05) -> AnchorEntity {
        let anchor = AnchorEntity(plane: .horizontal)

        // Create the floating pill
        let pill = ModelEntity(mesh: .generateSphere(radius: radius))
        pill.model?.materials = [SimpleMaterial(color: color, isMetallic: false)]
        pill.name = medicationName // Set name for easy identification
        
        // Attach a text label for medication details
        let textEntity = createTextEntity(medicationName: medicationName, dosage: dosage)

        // Position the text slightly above the pill
        textEntity.position = SIMD3(0, 0.1, 0)

        anchor.addChild(pill)
        anchor.addChild(textEntity)

        animateFloating(pill)
        animateFloating(textEntity) // Make text float too

        return anchor
    }

    private static func createTextEntity(medicationName: String, dosage: String) -> ModelEntity {
        let textMesh = MeshResource.generateText("\(medicationName)\n\(dosage)",
            extrusionDepth: 0.005, font: .systemFont(ofSize: 0.02))
        
        let textMaterial = SimpleMaterial(color: .white, isMetallic: false)
        let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])

        textEntity.generateCollisionShapes(recursive: true) // Enable tap detection
        return textEntity
    }

    private static func animateFloating(_ entity: ModelEntity) {
        let moveUp = Transform(translation: [0, 0.1, 0])
        let moveDown = Transform(translation: [0, 0, 0])

        entity.move(to: moveUp, relativeTo: entity.parent, duration: 1.5, timingFunction: .easeInOut)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            entity.move(to: moveDown, relativeTo: entity.parent, duration: 1.5, timingFunction: .easeInOut)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                animateFloating(entity) // Loop animation
            }
        }
    }
}
