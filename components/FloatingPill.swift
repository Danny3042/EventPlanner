import SwiftUI
import SceneKit

struct FloatingPillView: UIViewRepresentable {
    var medicationName: String
    var dosage: String
    var color: UIColor
    var radius: Float

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView(frame: .zero)
        scnView.scene = SCNScene()
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.black

        let pillNode = createFloatingPill(medicationName: medicationName, dosage: dosage, color: color, radius: radius)
        scnView.scene?.rootNode.addChildNode(pillNode)

        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}

    private func createFloatingPill(medicationName: String, dosage: String, color: UIColor, radius: Float) -> SCNNode {
        let pillNode = SCNNode()

        let cylinder = SCNCylinder(radius: CGFloat(radius), height: CGFloat(radius))
        let hemisphereTop = SCNSphere(radius: CGFloat(radius))
        let hemisphereBottom = SCNSphere(radius: CGFloat(radius))

        let cylinderNode = SCNNode(geometry: cylinder)
        let hemisphereTopNode = SCNNode(geometry: hemisphereTop)
        let hemisphereBottomNode = SCNNode(geometry: hemisphereBottom)

        hemisphereTopNode.position = SCNVector3(0, radius, 0)
        hemisphereBottomNode.position = SCNVector3(0, -radius, 0)

        let material = SCNMaterial()
        material.diffuse.contents = color
        cylinder.materials = [material]
        hemisphereTop.materials = [material]
        hemisphereBottom.materials = [material]

        pillNode.addChildNode(cylinderNode)
        pillNode.addChildNode(hemisphereTopNode)
        pillNode.addChildNode(hemisphereBottomNode)

        let textNode = createTextNode(medicationName: medicationName, dosage: dosage)
        textNode.position = SCNVector3(0, radius * 2 + 0.05, 0)
        pillNode.addChildNode(textNode)

        animateFloating(pillNode)
        animateFloating(textNode)

        return pillNode
    }

    private func createTextNode(medicationName: String, dosage: String) -> SCNNode {
        let text = SCNText(string: "\(medicationName)\n\(dosage)", extrusionDepth: 0.005)
        text.font = UIFont.systemFont(ofSize: 0.02)
        text.firstMaterial?.diffuse.contents = UIColor.white

        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(0.1, 0.1, 0.1)

        return textNode
    }

    private func animateFloating(_ node: SCNNode) {
        let moveUp = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 1.5)
        let moveDown = SCNAction.moveBy(x: 0, y: -0.1, z: 0, duration: 1.5)
        let sequence = SCNAction.sequence([moveUp, moveDown])
        let repeatForever = SCNAction.repeatForever(sequence)

        node.runAction(repeatForever)
    }
}
