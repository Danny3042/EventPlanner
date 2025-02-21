import SwiftUI
import ARKit
import RealityKit

class MedicationARViewController: UIViewController, ARSessionDelegate {

    var arView = ARView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        arView.frame = view.bounds
        view.addSubview(arView)
        arView.session.delegate = self
        arView.automaticallyConfigureSession = true

        // Add the floating pill when the view loads
        addFloatingPill(medicationName: "Example Medication", dosage: "500mg")
    }

    // This function creates a floating pill and places it in the AR scene
    func addFloatingPill(medicationName: String, dosage: String) {
        let pillAnchor = ARFloatingPill.createFloatingPill(medicationName: medicationName, dosage: dosage)
        arView.scene.addAnchor(pillAnchor)

        // Add tap gesture recognizer to the ARView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pillTapped))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func pillTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: arView)
        if let entity = arView.entity(at: location) {
            if entity.name == "Example Medication" {
                // Show an alert to educate the user about taking medications
                let alert = UIAlertController(title: "Medication Reminder", message: "Please take your medication as prescribed by your doctor.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

struct MedicationARView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MedicationARViewController {
        return MedicationARViewController()
    }

    func updateUIViewController(_ uiViewController: MedicationARViewController, context: Context) {}
}
