//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import SwiftUI

struct MedicationListView: View {
    @State private var medications = [("Aspirin", "100 mg"), ("Ibuprofen", "200 mg"), ("Paracetamol", "500 mg")]
    @State private var showAddMedicationSheet = false

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

            Button(action: {
                showAddMedicationSheet = true
            }) {
                Text("Add Medication")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showAddMedicationSheet) {
                AddMedicationView { name, dosage in
                    medications.append((name, dosage))
                    showAddMedicationSheet = false
                }
            }
        }
    }
}

struct AddMedicationView: View {
    @State private var name = ""
    @State private var dosage = ""
    var onAdd: (String, String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Medication Details")) {
                    TextField("Name", text: $name)
                    TextField("Dosage", text: $dosage)
                }
            }
            .navigationBarTitle("Add Medication", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                onAdd("", "")
            }, trailing: Button("Add") {
                onAdd(name, dosage)
            })
        }
    }
}

struct MedicationListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationListView()
    }
}
