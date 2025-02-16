//
//  AROnboardingView.swift
//  MediApp
//
//  Created by Daniel Ramzani on 16/02/2025.
//
import SwiftUI

struct AROnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    
    // Declare pages as a computed property
    var pages: [AROnboardingPage] {
        return [
            AROnboardingPage(title: "Welcome to AR!", description: "Discover the AR bubbles and pop them to relieve stress. Tap anywhere to pop the bubbles."),
            AROnboardingPage(title: "How to Play", description: "Tap on a bubble to pop it. Watch the bubbles disappear and hear a fun pop sound!"),
            AROnboardingPage(title: "Let's Get Started", description: "Ready to enter the AR world? Tap 'Start' to experience the magic.")
        ]
    }
    
    var body: some View {
        TabView {
            ForEach(pages.indices, id: \.self) { index in
                AROnboardingPageView(page: pages[index], isLastPage: index == pages.count - 1, onFinish: {
                    hasCompletedOnboarding = true
                })
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

struct AROnboardingPageView: View {
    let page: AROnboardingPage
    let isLastPage: Bool
    var onFinish: () -> Void
    
    var body: some View {
        VStack {
            Text(page.title)
                .font(.title)
                .bold()
                .padding()
            
            Text(page.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            if isLastPage {
                Button(action: onFinish) {
                    Text("Start AR Experience")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
    }
}


struct AROnboardingPage {
    let title: String
    let description: String
}
