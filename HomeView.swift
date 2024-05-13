//
//  HomeView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/05/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            List(viewModel.emails) { email in
                NavigationLink(destination: EmailDetailView(email: email, viewModel: viewModel)) {
                    Text(email.subject)
                }
            }
            .navigationBarTitle("Emails")
        }
    }
}

struct EmailDetailView: View {
    var email: Email
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            Text(email.subject)
            Text(email.body)
            Button(action: {
                viewModel.closeDetailScreen()
            }) {
                Text("Close")
            }
        }
    }
}


