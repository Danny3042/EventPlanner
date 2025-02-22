//
//  File.swift
//  MediApp
//
//  Created by Daniel Ramzani on 21/02/2025.
//

import Foundation
import SwiftUI

struct MessageBubble: View {
    var text: String
    var isUser: Bool

    var body: some View {
        HStack {
            if isUser {
                Spacer()
                Text(text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            } else {
                Text(text)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
        .padding(isUser ? .leading : .trailing, 50)
        .padding(.horizontal)
    }
}


