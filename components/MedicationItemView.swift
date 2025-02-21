//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 21/02/2025.
//

import SwiftUI

struct MedicationItemView: View {
    var medicationName: String
    var dosage: String

    var body: some View {
        VStack {
            Text(medicationName)
                .font(.headline)
                .padding(.bottom, 5)
            Text(dosage)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)

            FloatingPillView(medicationName: medicationName, dosage: dosage, color: .red, radius: 0.05)
                .frame(height: 200) // Adjust the height as needed
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
