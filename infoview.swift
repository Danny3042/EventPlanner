import SwiftUI

struct AllInformationView: View {
    let meditationDuration: Int
    let userFeeling: String
    let totalSessions: Int
    let averageDuration: Int
    @State private var animate = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .trim(from: 0, to: animate ? 1 : 0)
                        .stroke(Color.blue, lineWidth: 10)
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 1), value: animate)

                    Text("\(meditationDuration) min")
                        .font(.headline)
                }
                .padding()

                Text("User Feeling: \(userFeeling)")
                    .font(.headline)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.5)
                    .animation(.easeInOut(duration: 1).delay(0.2), value: animate)

                ProgressView(value: Double(meditationDuration), total: 60)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding()

                Text("Total Sessions: \(totalSessions)")
                    .font(.headline)

                Text("Average Duration: \(averageDuration) min")
                    .font(.headline)
            }
            .padding()
            .onAppear {
                animate = true
            }
            .navigationTitle("Statistics")
        }
    }
}

struct AllInformationView_Previews: PreviewProvider {
    static var previews: some View {
        AllInformationView(meditationDuration: 10, userFeeling: "Relaxed", totalSessions: 50, averageDuration: 15)
    }
}
