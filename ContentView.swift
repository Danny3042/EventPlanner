import SwiftUI

extension Notification.Name {
    static let onboardingCompleted = Notification.Name("onboardingCompleted")
}

struct ContentView: View {
    
    // MARK: - Variables for HomeView
    @StateObject var homeViewModel = HomeViewModel()
    @State private var hasShownOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasShownOnboarding")
    
    var body: some View {
        VStack {
            if hasShownOnboarding {
                UITabBarWrapper([
                    TabBarElement(tabBarElementItem: .init(title: "Home", systemImageName: "house.fill")) {
                        HomeView()
                    },
                    TabBarElement(tabBarElementItem: .init(title: "Schedule", systemImageName: "calendar")) {
                        ScheduleView()
                    },
                    TabBarElement(tabBarElementItem: .init(title: "Insights", systemImageName: "waveform.path.ecg.rectangle.fill")) {
                        InsightsView()
                    }
                ])
            } else {
                OnboardingView()
            }
        }
        .onAppear {
            hasShownOnboarding = UserDefaults.standard.bool(forKey: "hasShownOnboarding")
        }
        .onReceive(NotificationCenter.default.publisher(for: .onboardingCompleted)) { _ in
            hasShownOnboarding = true
        }

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
