//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 20/02/2025.
//

import SwiftUI

struct FloatingActionButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 24))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.purple)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}
