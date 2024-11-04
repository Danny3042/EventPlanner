import SwiftUI

struct ContentView: View {
    
    // MARK: - Variables for HomeView
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        UITabBarWrapper([
            TabBarElement(tabBarElementItem: .init(title: "Home", systemImageName: "house.fill")) {
                HomeView(moodEntries: homeViewModel.moodEntries, recommendations: homeViewModel.recommendations)
            },
            TabBarElement(tabBarElementItem: .init(title: "Schedule", systemImageName: "calendar")) {
                ScheduleView()
            },
            TabBarElement(tabBarElementItem: .init(title: "Insights", systemImageName: "waveform.path.ecg.rectangle.fill")) {
                InsightsView()
            }
        ])
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
