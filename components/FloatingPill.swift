//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import RealityKit

class ARFloatingPill {
    static func createFloatingPill() -> ModelEntity {
        let pill = ModelEntity(mesh: .generateSphere(radius: 0.05))
        pill.model?.materials = [SimpleMaterial(color: .red, isMetallic: false)]
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(pill)
        
        let moveUp = Transform(scale: .one, rotation: simd_quatf(), translation: [0, 0.2, 0])
        let moveDown = Transform(scale: .one, rotation: simd_quatf(), translation: [0, 0, 0])
        
        pill.move(to: moveUp, relativeTo: anchor, duration: 1.0, timingFunction: .easeInOut)
        pill.move(to: moveDown, relativeTo: anchor, duration: 1.0, timingFunction: .easeInOut)
        
        return pill
    }
}
