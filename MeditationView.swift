import SwiftUI
import SwiftData
import AVFoundation

struct MeditationView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var meditationDuration: Int = 5
    @State private var isMeditating = false
    @State private var progress: CGFloat = 0.0
    @State private var scale: CGFloat = 1.0
    @State private var player: AVAudioPlayer?
    @State private var isChimePlaying = false
    @State private var showPopover = false
    @State private var remainingTime: Int = 0
    @State private var timer: Timer?

    var body: some View {
        VStack {

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

            Spacer()

            Text("Current duration: \(meditationDuration) minutes")
                .padding()

            if isMeditating {
                Text("Remaining time: \(remainingTime) seconds")
                    .padding()
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

            if isMeditating {
                Button(action: stopMeditation) {
                    Text("Stop Meditation")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding()
            }

            Button(action: {
                showPopover = true
            }) {
                Text("Set Duration")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding()
            .popover(isPresented: $showPopover) {
                VStack {
                    Text("Select Duration")
                        .font(.headline)
                        .padding()
                    Stepper(value: $meditationDuration, in: 1...30, step: 5) {
                        Text("\(meditationDuration) minutes")
                    }
                    .padding()
                    Button("Done") {
                        showPopover = false
                    }
                    .padding()
                }
                .padding()
            }

            if isChimePlaying {
                Button(action: stopChimeSound) {
                    Text("Stop Chime")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding()
            }
        }
        .padding()
    }

    func startMeditation() {
        isMeditating = true
        scale = 1.5  // Start animation
        remainingTime = meditationDuration * 60

        // Haptic feedback starts
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // Start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopMeditation()
                playChimeSound()
            }
        }
    }

    func stopMeditation() {
        timer?.invalidate()
        isMeditating = false
        scale = 1.0  // Stop pulsating
    }

    func playChimeSound() {
        guard let url = Bundle.main.url(forResource: "chime", withExtension: "mp3") else {
            print("Chime sound file not found")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            isChimePlaying = true
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    func stopChimeSound() {
        player?.stop()
        isChimePlaying = false
    }
}
