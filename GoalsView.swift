import SwiftUI

struct GoalsView: View {
    @State private var goals: [Goal] = UserDefaults.standard.loadGoals()
    @State private var showAddGoalModal = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        ForEach(goals) { goal in
                            VStack(alignment: .leading) {
                                Text(goal.title)
                                    .font(.headline)
                                ProgressView(value: Double(goal.currentProgress), total: Double(goal.targetDuration))
                                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                Text("Progress: \(goal.currentProgress)/\(goal.targetDuration) weeks")
                                    .font(.subheadline)
                            }
                        }
                        .onDelete(perform: deleteGoal)
                    }
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddGoalModal = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .padding()
                        .sheet(isPresented: $showAddGoalModal) {
                            AddGoalModal(goals: $goals)
                        }
                    }
                }
            }
            .navigationTitle("Goals")
        }
    }

    private func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
        UserDefaults.standard.saveGoals(goals)
    }

    private func updateGoalProgress(goalId: UUID, progress: Int) {
        if let index = goals.firstIndex(where: { $0.id == goalId && $0.title.lowercased() == "meditate" }) {
            goals[index].currentProgress += progress
            UserDefaults.standard.saveGoals(goals)
        }
    }
    
    
func completeMeditationSession() {
    if let meditateGoal = goals.first(where: { $0.title.lowercased() == "meditate" }) {
        let goalId: UUID = meditateGoal.id
        let progressToAdd: Int = 1
        updateGoalProgress(goalId: goalId, progress: progressToAdd)
    }
}
}





extension UserDefaults {
    private static let goalsKey = "goals"

    func saveGoals(_ goals: [Goal]) {
        if let encoded = try? JSONEncoder().encode(goals) {
            set(encoded, forKey: UserDefaults.goalsKey)
        }
    }

    func loadGoals() -> [Goal] {
        if let savedGoals = data(forKey: UserDefaults.goalsKey),
           let decodedGoals = try? JSONDecoder().decode([Goal].self, from: savedGoals) {
            return decodedGoals
        }
        return []
    }
}

#Preview {
    GoalsView()
}
