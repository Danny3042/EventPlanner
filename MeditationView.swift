import SwiftUI
import UIKit

struct MeditationView: View {
    @State private var inhaleDuration: Double = 4
    @State private var holdDuration: Double = 2
    @State private var exhaleDuration: Double = 4
    @State private var currentPhase: BreathingPhase = .inhale
    @State private var timer: Timer?
    @State private var timerCountDown: Double = 0
    @State private var breathingAnimationScale: CGFloat = 1.0
    
    // Haptic feedback generator
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    enum BreathingPhase {
        case inhale, hold, exhale
    }
    
    var body: some View {
        VStack {
            Text("Breathing Meditation")
                .font(.title)
                .padding()
            
            Text("Current Phase: \(currentPhase == .inhale ? "Inhale" : currentPhase == .hold ? "Hold" : "Exhale")")
                .font(.headline)
                .padding()
            
            // Pulsating Circle Animation
            Circle()
                .scaleEffect(breathingAnimationScale) // Pulsating effect
                .frame(width: 200, height: 200)
                .foregroundColor(Color.blue.opacity(0.4))
                .padding()
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true), value: breathingAnimationScale
                )
            
            Button(action: startBreathing) {
                Text("Start Breathing")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Timer display
            Text("\(Int(timerCountDown)) seconds remaining")
                .font(.subheadline)
                .padding()
        }
        .onChange(of: currentPhase) { newPhase in
            // Update animation scale and provide haptic feedback at each phase
            updateBreathingAnimation(for: newPhase)
            feedbackGenerator.impactOccurred()
        }
    }
    
    // Function to start the breathing timer
    func startBreathing() {
        // Prepare feedback
        feedbackGenerator.prepare()
        
        // Start the first phase
        startPhaseTimer(for: .inhale)
    }
    
    // Function to start a phase (inhale, hold, exhale)
    func startPhaseTimer(for phase: BreathingPhase) {
        currentPhase = phase
        
        let duration: Double
        
        switch phase {
        case .inhale:
            duration = inhaleDuration
        case .hold:
            duration = holdDuration
        case .exhale:
            duration = exhaleDuration
        }
        
        // Set the timer for the phase
        timerCountDown = duration
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timerCountDown -= 1
            
            if self.timerCountDown <= 0 {
                self.timer?.invalidate()
                self.timer = nil
                
                // Move to the next phase
                self.nextPhase()
            }
        }
    }
    
    // Function to move to the next phase
    func nextPhase() {
        switch currentPhase {
        case .inhale:
            startPhaseTimer(for: .hold)
        case .hold:
            startPhaseTimer(for: .exhale)
        case .exhale:
            // Optionally, loop back to inhale or finish meditation
            startPhaseTimer(for: .inhale)
        }
    }
    
    // Function to update the animation and scale for each phase
    func updateBreathingAnimation(for phase: BreathingPhase) {
        switch phase {
        case .inhale:
            breathingAnimationScale = 1.5 // Expand during inhale
        case .hold:
            breathingAnimationScale = 1.0 // Hold at the original size
        case .exhale:
            breathingAnimationScale = 0.5 // Shrink during exhale
        }
    }
}
