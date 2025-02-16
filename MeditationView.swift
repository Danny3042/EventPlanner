//
//  Untitled.swift
//  MediApp
//
//  Created by Daniel Ramzani on 16/02/2025.
//

import SwiftUI

struct MeditationView: View {
    var body: some View {
        VStack {
            Text("Relax & Breathe")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Follow the animation to guide your breathing. Inhale as the circle expands, exhale as it shrinks.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()

            // Lottie Animation
            AnimationView()
                .frame(width: 300, height: 300)

            Spacer()
        }
        .padding()
    }
}
