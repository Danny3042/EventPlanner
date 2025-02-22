import SwiftUI

struct AROnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    let onboardingData: [(image: String, title: String, description: String)] = [
        ("meditation1", "Welcome to AR Meditation", "Immerse yourself in a calming AR space for mindfulness and relaxation."),
        ("meditation2", "How It Works", "Visualize floating meditation aids in your real space to guide your focus."),
        ("meditation3", "Get Started", "Find a quiet place, start the session, and let AR guide you.")
    ]
    
    var body: some View {
        if hasSeenOnboarding {
            ARExperienceView()
        } else {
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    AROnboardingPageViewWrapper(
                        data: onboardingData[index],
                        isLastPage: index == onboardingData.count - 1,
                        onSkip: { hasSeenOnboarding = true }
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }
}

import SwiftUI

struct AROnboardingPageView: View {
    var image: String
    var title: String
    var description: String
    var isLastPage: Bool
    var onSkip: () -> Void

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()

            Text(title)
                .font(.title)
                .bold()
                .padding()

            Text(description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()

            if isLastPage {
                Button(action: onSkip) {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
    }
}

struct AROnboardingPageViewWrapper: View {
    var data: (image: String, title: String, description: String)
    var isLastPage: Bool
    var onSkip: () -> Void

    var body: some View {
        AROnboardingPageView(
            image: data.image,
            title: data.title,
            description: data.description,
            isLastPage: isLastPage,
            onSkip: onSkip
        )
    }
}



