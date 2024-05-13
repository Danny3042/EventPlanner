//
//  ComingSoon.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/05/2024.
//

import SwiftUI

struct ComingSoon: View {
    var body: some View {
        VStack {
            Text("Screen under construction")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.primary)
            Text("This screen is under construction. Please check back later.")
                .font(.body)
                .padding()
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    ComingSoon()
}
