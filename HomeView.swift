//
//  HomeView.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 12/05/2024.
//

import SwiftUI
import UIKit
import MessageUI

// MARK: - Mail View

struct MailView: UIViewControllerRepresentable {
    
    // MARK: - Variables
    
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    @Environment(\.presentationMode) var presentation
    
    // MARK: - Coordinator

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation, result: $result)
    }
    
    // MARK: - UIViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(Config.reportBugSubject)
        vc.setToRecipients([Config.contactEmail])
        vc.navigationBar.prefersLargeTitles = true
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {

    }
}


