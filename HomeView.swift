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
                .foregroundColor(.secondary)
            NavigationLink(destination: destination) {
                Text("Go")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemBlue))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct HomeView: View {
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

                    CardView(
                        title: "Track Medications in AR",
                        description: "View your medication schedule in augmented reality.",
                        iconName: "pills",
                        destination: AnyView(MedicationListView())
                    )

                }
                .padding(.top)
            }
            .navigationTitle("Home")
        }
    }
}
