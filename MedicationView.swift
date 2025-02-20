//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import SwiftUI
import SwiftData




struct MedicationListView: View {
    @Query private var medications: [Medication]
    @Environment(\.modelContext) private var context
    @State private var showingAddMedication = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(medications) { med in
                    HStack {
                        MedicationCardView(medication: med)
                        Spacer()
                        Button(action: {
                            med.taken.toggle()
                            try? context.save()
                        }) {
                            Circle()
                                .fill(med.taken ? Color.green : Color.gray)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Medications")
            .toolbar {
                Button("Add") {
                    showingAddMedication = true
                }
            }
            .sheet(isPresented: $showingAddMedication) {
                AddMedicationView(isPresented: $showingAddMedication)
            }
        }
    }
}

struct MedicationCardView: View {
    let medication: Medication

    var body: some View {
        VStack(alignment: .leading) {
            Text(medication.name)
                .font(.headline)
            Text(medication.dosage)
                .font(.subheadline)
            Text("\(medication.pillsRemaining) left")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct AddMedicationView: View {
    @Environment(\.modelContext) private var context
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @State private var dosage: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Medication Details")) {
                    TextField("Name", text: $name)
                    TextField("Dosage", text: $dosage)
                }
            }
            .navigationTitle("Add Medication")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newMed = Medication(name: name, dosage: dosage, pillsRemaining: 30)
                        context.insert(newMed)
                        try? context.save()
                        isPresented = false
                    }
                }
            }
        }
    }
}
