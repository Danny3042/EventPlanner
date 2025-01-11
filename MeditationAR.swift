import UIKit
import ARKit
import SceneKit
import SwiftUI
import ARKit


class ARViewController: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARSCNView and set it up
        setupARView()
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
        
        // Add 3D object to the AR scene
        add3DObject()
    }
    
    // Set up ARSCNView
    func setupARView() {
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        view.addSubview(sceneView)
    }
    
    // Add 3D object (sphere)
    func add3DObject() {
        let sphere = SCNSphere(radius: 0.1)
        sphere.firstMaterial?.diffuse.contents = UIColor.systemBlue
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(0, 0, -0.5)
        
        sceneView.scene.rootNode.addChildNode(sphereNode)
    }
    
    // ARSCNViewDelegate methods
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


struct ARViewRepresentable: UIViewControllerRepresentable {
    
    // Create the ARViewController instance
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }

    // Update the UIViewController (currently not needed)
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // You can update the ARViewController if needed in future
    }
}
