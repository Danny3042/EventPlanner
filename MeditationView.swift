import SwiftUI
import SwiftData
import AVFoundation

struct MeditationView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var meditationDuration = 1  // Default duration in minutes
    @State private var isMeditating = false
    @State private var progress: CGFloat = 0.0
    @State private var scale: CGFloat = 1.0
    @State private var player: AVAudioPlayer?

    var body: some View {
        VStack {
            Text("Set Meditation Duration")
                .font(.headline)
                .padding()

            Picker("Duration", selection: $meditationDuration) {
                ForEach([1, 5, 10, 15, 20, 30], id: \.self) { minutes in
                    Text("\(minutes) min").tag(minutes)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()

            // Pulsating Animation
            Circle()
                .fill(Color.blue.opacity(0.5))
                .frame(width: 200, height: 200)
                .scaleEffect(scale)
                .animation(isMeditating ? .easeInOut(duration: 3).repeatForever(autoreverses: true) : .default, value: scale)
                .onAppear {
                    scale = 1.2  // Start pulsating
                }

            Text(isMeditating ? "Breathe in... Breathe out..." : "Ready to Start")
                .font(.headline)
                .padding()

            Spacer()

            Button(action: startMeditation) {
                Text(isMeditating ? "Meditating..." : "Start Meditation")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isMeditating ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .animation(.easeInOut, value: isMeditating)
            }
            .disabled(isMeditating)
            .padding()
        }
        .padding()
    }

    func startMeditation() {
        isMeditating = true
        scale = 1.5  // Start animation

        // Haptic feedback starts
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // meditation session simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(meditationDuration) * 60) {
            isMeditating = false
            scale = 1.0  // Stop pulsating

            // Session saved to SwiftData
            let newSession = MeditationSession(date: Date(), duration: meditationDuration)
            modelContext.insert(newSession)

            // Haptic feedback when completed
            let successGenerator = UINotificationFeedbackGenerator()
            successGenerator.notificationOccurred(.success)

            playChimeSound()
        }
    }

    func playChimeSound() {
        guard let url = Bundle.main.url(forResource: "chime", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
