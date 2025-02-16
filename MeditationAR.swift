import UIKit
import ARKit
import SceneKit
import SwiftUI


class ARViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - Properties
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the ARSCNView
        setupARView()
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
        
        // Add tap gesture recognizer for popping bubbles
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
        // Start adding bubbles
        addRandomBubbles()
    }
    
    func setupARView() {
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        view.addSubview(sceneView)
    }
    
    // MARK: - Bubble Management
    func addRandomBubbles() {
        for _ in 0..<10 { // Add 10 bubbles
            let bubble = SCNSphere(radius: 0.05) // 5 cm radius
            bubble.firstMaterial?.diffuse.contents = UIColor.random() // Random bubble color
            
            let bubbleNode = SCNNode(geometry: bubble)
            
            // Random position near the user
            let x = Float.random(in: -0.5 ... 0.5) // Random x position
            let y = Float.random(in: -0.5 ... 0.5) // Random y position
            let z = Float.random(in: -1.0 ... -0.5) // Random z position (further away)
            bubbleNode.position = SCNVector3(x, y, z)
            
            sceneView.scene.rootNode.addChildNode(bubbleNode)
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // Get tap location in the scene
        let location = gesture.location(in: sceneView)
        
        // Perform a hit test to find tapped nodes
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if let hitNode = hitResults.first?.node {
            // Remove the tapped node
            hitNode.removeFromParentNode()
            
            // Optional: Play a sound or show an animation
            playPopSound()
        }
    }
    
    func playPopSound() {
        // Play a "pop" sound
        let popSound = SCNAudioSource(fileNamed: "pop.mp3")
        popSound?.load()
        
        let audioPlayer = SCNAudioPlayer(source: popSound!)
        sceneView.scene.rootNode.addAudioPlayer(audioPlayer)
    }
    
    // MARK: - ARSCNViewDelegate Methods
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR Session Failed: \(error.localizedDescription)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("AR Session Interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("AR Session Resumed")
    }
}

// Extension for random bubble colors
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}

struct ARViewRepresentable: UIViewControllerRepresentable {
    
    @Binding var isFullScreen: Bool

    // Create the ARViewController instance
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }

    // Update the UIViewController (currently not needed)
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        if isFullScreen {
            uiViewController.sceneView.frame = UIScreen.main.bounds
        }
    }
}

//MARK: SwiftUI AR Experience view

struct ARExperienceView: View {
    @State private var hasCompletedAROnboarding = UserDefaults.standard.bool(forKey: "hasCompletedAROnboarding")
    
    var body : some View {
        VStack {
            if hasCompletedAROnboarding {
                ARExperienceView()
            } else {
                AROnboardingView(hasCompletedAROnboarding: $hasCompletedAROnboarding)
            }
        }
        .onChange(of: hasCompletedAROnboarding) {
            UserDefaults.standard.set($0, forKey: "hasCompletedAROnboarding")
        }
    }
}
