//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import SwiftUI

struct MedicationListView: View {
    @State private var medications = [("Medication 1", "Dosage 1"), ("Medication 2", "Dosage 2"), ("Medication 3", "Dosage 3")]

    var body: some View {
        VStack {
            Text("Medication List")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            List(medications, id: \.0) { medication in
                MedicationItemView(medicationName: medication.0, dosage: medication.1)
            }
            .listStyle(PlainListStyle())

            Button(action: addMedication) {
                Text("Add Medication")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    private func addMedication() {
        medications.append(("New Medication", "New Dosage"))
    }
}

struct MedicationListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationListView()
    }
}
