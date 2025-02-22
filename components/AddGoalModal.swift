//
//  AddGoalModal.swift
//  MediApp
//
//  Created by Daniel Ramzani on 22/02/2025.
//


import SwiftUI

struct AddGoalModal: View {
    @Binding var goals: [Goal]
    @State private var newGoalTitle: String = ""
    @State private var newGoalTargetDuration: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Goal Title", text: $newGoalTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack {
                    TextField("Target Duration (weeks)", text: $newGoalTargetDuration)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                .padding()
                Button(action: addGoal) {
                    Text("Add Goal")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("Add New Goal")
        }
    }

    private func addGoal() {
        guard let targetDuration = Int(newGoalTargetDuration), !newGoalTitle.isEmpty else { return }
        let newGoal = Goal(title: newGoalTitle, targetDuration: targetDuration, currentProgress: 0)
        goals.append(newGoal)
        UserDefaults.standard.saveGoals(goals)
        newGoalTitle = ""
        newGoalTargetDuration = ""
    }
}
