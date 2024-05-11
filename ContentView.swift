import SwiftUI

struct ContentView: View {
    var body: some View {
        UITabBarWrapper([
            TabBarElement(tabBarElementItem: .init(title: "Home", systemImageName: "house.fill")) {
                Text("First View")
            },
            TabBarElement(tabBarElementItem: .init(title: "Schedule", systemImageName: "calendar")) {
                Text("Second View")
            },
            TabBarElement(tabBarElementItem: .init(title: "Care", systemImageName: "list.bullet.clipboard.fill")) {
                Text("Third View")
            }
        ])
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
