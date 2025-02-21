import SwiftUI
import RealityKit
import ARKit

struct MedicationARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        // Create a RealityKit entity
        let box = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        let modelEntity = ModelEntity(mesh: box, materials: [material])
        
        // Add the entity to the scene
        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.addChild(modelEntity)
        arView.scene.addAnchor(anchorEntity)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
