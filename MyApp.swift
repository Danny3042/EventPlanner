import SwiftUI
import SwiftData

@main
struct MyApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
                    .modelContainer(for: [DayEntry.self, Medication.self])
            } else {
                OnboardingView()
            }
            
        }
    }
}
