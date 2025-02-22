import SwiftUI

struct ReflectionView: View {
    let meditationDuration: Int
    @State private var userFeeling: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Time Meditating: \(meditationDuration) minutes")
                    .font(.headline)
                    .padding()

                Text("How do you feel after meditating?")
                    .font(.headline)
                    .padding()

                TextField("Enter your feelings here", text: $userFeeling)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                NavigationLink(destination: AllInformationView(meditationDuration: meditationDuration, userFeeling: userFeeling, totalSessions: 50, averageDuration: 15)) {
                    Text("Submit")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Reflection")
    }
}

struct ReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionView(meditationDuration: 15)
    }
}
