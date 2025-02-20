import SwiftUI

struct CardView: View {
    var title: String
    var description: String
    var iconName: String
    var destination: AnyView

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 5)
                Text(title)
                    .font(.headline)
            }
            .padding(.bottom, 5)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
            NavigationLink(destination: destination) {
                Text("Go")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct HomeView: View {
    var moodEntries: [MoodEntry]
    var recommendations: [Recommendation]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    CardView(
                        title: "Access AR",
                        description: "Tap here to access AR and start popping bubbles.",
                        iconName: "arkit",
                        destination: AnyView(ARViewRepresentable(isFullScreen: .constant(true)))
                    )

                    CardView(
                        title: "Start Meditation",
                        description: "Begin a guided meditation session to relax and unwind.",
                        iconName: "leaf.arrow.circlepath",
                        destination: AnyView(MeditationView())
                    )
                }
                .padding(.top)
            }
            .navigationTitle("Home")
        }
    }
}
