//
//  ListContent.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/05/2024.
//

import SwiftUI

struct ReplyInboxScreen: View {
    @State private var showDialog = false
    @State private var emailSubject = ""
    @State private var emailBody = ""
    
    var body: some View {
        VStack {
            // Replace this with your actual email list
            List {
                ForEach(0..<5) { _ in
                    Text("Email Item")
                }
            }
            
            // Floating Action Button
            if !showDialog {
                Button(action: {
                    self.showDialog = true
                }) {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding()
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .shadow(radius: 10)
            }
            
            // Dialog
            if showDialog {
                VStack {
                    Text("Compose Email")
                        .font(.headline)
                    TextField("Subject", text: $emailSubject)
                        .padding()
                        .border(Color.gray, width: 0.5)
                    TextField("Body", text: $emailBody)
                        .padding()
                        .border(Color.gray, width: 0.5)
                    HStack {
                        Button(action: {
                            self.showDialog = false
                        }) {
                            Text("Cancel")
                        }
                        Button(action: {
                            // Handle email sending here
                            self.showDialog = false
                        }) {
                            Text("Send")
                        }
                    }
                    .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
    }
}

struct ReplyInboxScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReplyInboxScreen()
    }
}
