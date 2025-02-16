//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 16/02/2025.
//

import SwiftUI
import DotLottie


struct AnimationView: View {
    var body: some View {
        DotLottieAnimation(fileName: "breathe", config: AnimationConfig(autoplay: true, loop: true)).view()
    }
}
