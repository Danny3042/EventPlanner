import SwiftUI

struct HomeView: View {
    var moodEntries: [MoodEntry]
    var recommendations: [Recommendation]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome to Mindfulness App")
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
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}
