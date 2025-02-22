import SwiftUI
import ARKit

struct ARViewRepresentable: UIViewControllerRepresentable {
    @Binding var isFullScreen: Bool
    @Binding var showCompletionAlert: Bool

    func makeUIViewController(context: Context) -> ARViewController {
        let arViewController = ARViewController()
        arViewController.completionHandler = {
            showCompletionAlert = true
        }
        return arViewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // Update the view controller if needed
    }
}

class ARViewController: UIViewController, ARSCNViewDelegate {
    var sceneView: ARSCNView!
    var bubbleCount = 10
    var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        addRandomBubbles()
    }

    func setupARView() {
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        view.addSubview(sceneView)
    }

    func addRandomBubbles() {
        for _ in 0..<bubbleCount {
            let bubble = SCNSphere(radius: 0.05)
            bubble.firstMaterial?.diffuse.contents = UIColor.random()
            let bubbleNode = SCNNode(geometry: bubble)
            let x = Float.random(in: -0.5 ... 0.5)
            let y = Float.random(in: -0.5 ... 0.5)
            let z = Float.random(in: -1.0 ... -0.5)
            bubbleNode.position = SCNVector3(x, y, z)
            sceneView.scene.rootNode.addChildNode(bubbleNode)
        }
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        if let hitNode = hitResults.first?.node {
            hitNode.removeFromParentNode()
            bubbleCount -= 1
            if bubbleCount == 0 {
                completionHandler?()
            }
            playPopSound()
        }
    }

    func playPopSound() {
        let popSound = SCNAudioSource(fileNamed: "pop.mp3")
        popSound?.load()
        let audioPlayer = SCNAudioPlayer(source: popSound!)
        sceneView.scene.rootNode.addAudioPlayer(audioPlayer)
    }
}

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

struct ARMeditationView: View {
    @State private var isFullScreen = false
    @State private var showCompletionAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Text("AR Experience")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: ARViewRepresentable(isFullScreen: $isFullScreen, showCompletionAlert: $showCompletionAlert)
                                .edgesIgnoringSafeArea(.all)) {
                    Text("Start AR")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .alert(isPresented: $showCompletionAlert) {
                Alert(title: Text("Well Done!"), message: Text("You popped all the bubbles."), dismissButton: .default(Text("OK")))
            }
        }
    }
}
