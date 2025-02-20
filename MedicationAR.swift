//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import SwiftUI
import ARKit
import Vision

struct MedicationARView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARMedicationViewController {
        return ARMedicationViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARMedicationViewController, context: Context) { }
}

class ARMedicationViewController: UIViewController, ARSCNViewDelegate {
    var sceneView = ARSCNView()
    var recognizedPills: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.frame = view.bounds
        sceneView.delegate = self
        sceneView.session.run(ARWorldTrackingConfiguration())
        view.addSubview(sceneView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, options: nil)
        
        if let hitNode = hitTestResults.first?.node {
            showMedicationDetails(for: hitNode)
            playHapticFeedback()
        }
    }
    
    func showMedicationDetails(for node: SCNNode) {
        let label = UILabel()
        label.text = "Medication: Aspirin\nDosage: 500mg"
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.7)
        label.frame = CGRect(x: 10, y: 10, width: 200, height: 100)
        view.addSubview(label)
    }
    
    func playHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

