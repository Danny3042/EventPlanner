//
//  SettingsViewModel.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/05/2024.
//

import SwiftUI
import MessageUI


// MARK: - Settings View Model

class SettingsViewModel: ObservableObject {
    
    // MARK: - Mail
    
    @Published var isShowingMailView = false
    @Published var result: Result<MFMailComposeResult, Error>? = nil
    
    func toggleMail() {
        self.isShowingMailView.toggle()
    }
    
}
