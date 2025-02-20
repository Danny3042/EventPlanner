import SwiftUI
import Vision
import VisionKit
import ARKit

class MedicationARViewController: UIViewController, VNDocumentCameraViewControllerDelegate, ARSCNViewDelegate {

    var sceneView = ARSCNView()
    var recognizedText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.frame = view.bounds
        view.addSubview(sceneView)
        sceneView.delegate = self
        sceneView.session.run(ARWorldTrackingConfiguration())
    }

    func scanMedicationLabel() {
        let scannerVC = VNDocumentCameraViewController()
        scannerVC.delegate = self
        present(scannerVC, animated: true)
    }

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true)
        let image = scan.imageOfPage(at: 0)
        recognizeText(from: image)
    }

    func recognizeText(from image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let request = VNRecognizeTextRequest { request, error in
            guard let results = request.results as? [VNRecognizedTextObservation], error == nil else { return }
            
            let extractedText = results.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
            self.recognizedText = extractedText
            
            print("Extracted Text: \(extractedText)")
            self.saveMedicationInfo(medicationName: extractedText)
        }
        
        request.recognitionLevel = .accurate
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }

    func saveMedicationInfo(medicationName: String) {
        let newMedication = Medication(name: medicationName, dateScanned: Date())
        // Save to SwiftData
        MedicationStore.shared.save(medication: newMedication)
        
        // Add the floating pill with the recognized medication name
        addFloatingPill(medicationName: medicationName, dosage: "500mg")  // You can also extract dosage if available
    }

    // This function creates a floating pill and places it in the AR scene
    func addFloatingPill(medicationName: String, dosage: String) {
        // Create an AR floating pill as a 3D sphere
        let pillNode = createFloatingPill()

        // Place the pill node at a location in the scene
        let pillPosition = SCNVector3(x: 0, y: 0.2, z: -0.5)  // Example position (adjust as needed)
        pillNode.position = pillPosition
        
        // Add the pill node to the scene
        sceneView.scene.rootNode.addChildNode(pillNode)

        // Optionally: Show a label or other text with the medication details
        showMedicationDetails(medicationName: medicationName, dosage: dosage)
    }

    // Create a floating pill (sphere) node
    func createFloatingPill() -> SCNNode {
        let pillGeometry = SCNSphere(radius: 0.05)
        let pillMaterial = SCNMaterial()
        pillMaterial.diffuse.contents = UIColor.red
        pillGeometry.materials = [pillMaterial]
        
        let pillNode = SCNNode(geometry: pillGeometry)
        return pillNode
    }

    func showMedicationDetails(medicationName: String, dosage: String) {
        // Create a 3D text node to show medication details (can be added as a label in AR)
        let text = "Medication: \(medicationName)\nDosage: \(dosage)"
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        let textMaterial = SCNMaterial()
        textMaterial.diffuse.contents = UIColor.white
        textGeometry.materials = [textMaterial]
        
        let textNode = SCNNode(geometry: textGeometry)
        
        // Position the text near the pill
        textNode.position = SCNVector3(x: 0, y: 0.3, z: -0.5)
        
        // Add the text node to the scene
        sceneView.scene.rootNode.addChildNode(textNode)
    }
}

struct MedicationARView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MedicationARViewController {
        return MedicationARViewController()
    }
    
    func updateUIViewController(_ uiViewController: MedicationARViewController, context: Context) {}
}
