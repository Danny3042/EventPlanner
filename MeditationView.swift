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
    @State private var navigateToStatistics = false
    @State private var userFeeling: String = ""
    @State private var goalsView = GoalsView()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                // Pulsating Animation
                Circle()
                    .fill(Color.blue.opacity(1))
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
                    Text("Remaining time: \(formattedRemainingTime)")
                        .padding()
                        .animation(.easeInOut, value: remainingTime)
                }

                Text(isMeditating ? "Breathe in... Breathe out..." : "Ready to Start")
                    .font(.headline)
                    .padding()

                Spacer()

                HStack {
                    if !isMeditating {
                        Button(action: startMeditation) {
                            Text("Start")
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .animation(.easeInOut, value: isMeditating)
                        }
                        .padding()
                    }

                    if isMeditating {
                        Button(action: stopMeditation) {
                            Text("Stop")
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .padding()
                    }

                    Button(action: {
                        showPopover = true
                    }) {
                        Text("Duration")
                            .padding()
                            .frame(width: 100, height: 100)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
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
                            Text("Stop")
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                }

                NavigationLink(value: navigateToStatistics) {
                    EmptyView()
                }
                .navigationDestination(isPresented: $navigateToStatistics) {
                    ReflectionView(meditationDuration: meditationDuration)
                }
            }
            .padding()
        }
    }

    var formattedRemainingTime: String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
                withAnimation {
                    remainingTime -= 1
                }
            } else {
                stopMeditation()
                playChimeSound()
                navigateToStatistics = true
            }
        }
    }

    func stopMeditation() {
        timer?.invalidate()
        isMeditating = false
        scale = 1.0
        goalsView.completeMeditationSession()
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
