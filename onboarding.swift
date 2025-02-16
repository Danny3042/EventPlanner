import SwiftUI

struct OnboardingView: View {
    
    let pages = [
        OnboardingPage(title: "Welcome", description: "Welcome to our Mindfulness app. Let's begin your journey to a peaceful mind."),
        OnboardingPage(title: "Track Your Mood", description: "Log your mood every day to track your mental well-being."),
        OnboardingPage(title: "Practice Mindfulness", description: "Learn and practice mindfulness to manage stress and anxiety."),
        OnboardingPage(title: "Get Started", description: "Ready to start? Let's dive in!")
    ]
    
    var body: some View {
        TabView {
            ForEach(pages.indices, id: \.self) { index in
                OnboardingPageView(page: pages[index], isLastPage: index == pages.count - 1)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    let isLastPage: Bool
    
    var body: some View {
        VStack {
            Text(page.title)
                .font(.title)
                .bold()
                .padding()
            
            Text(page.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            if isLastPage {
                Button(action: {
                    // Mark onboarding as completed and navigate to the Home view
                    UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    // Update the flag in the parent view
                    NotificationCenter.default.post(name: .onboardingCompleted, object: nil)
                }) {
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




struct OnboardingPage {
    let title: String
    let description: String
}
