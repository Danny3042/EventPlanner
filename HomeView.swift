import SwiftUI

struct HomeView: View {
    var moodEntries: [MoodEntry]
    var recommendations: [Recommendation]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Discover the AR bubbles and pop them to relieve stress. Tap anywhere to pop the bubbles.")
                        .font(.title)
                        .padding()

                    NavigationLink(destination: ARViewRepresentable(isFullScreen: .constant(true))) {
                        Text("Tap here to access AR")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                NavigationLink(destination: MeditationView()) {
                    Text("Start Meditation")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Home")
        }
    }
}
