//
//  HomeViewModel.swift
//  EventPlanner
//
//  Created by Daniel Ramzani on 13/05/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var emails: [Email] = []
    @Published var selectedEmails: Set<Int> = []
    @Published var openedEmail: Email?
    @Published var isDetailOnlyOpen: Bool = false
    @Published var loading: Bool = false
    @Published var error: String?

    private var emailsRepository: EmailsRepository
    private var cancellables = Set<AnyCancellable>()

    init(emailsRepository: EmailsRepository = EmailsRepositoryImpl()) {
        self.emailsRepository = emailsRepository
        loadEmails()
    }

    private func loadEmails() {
        self.loading = true
        emailsRepository.getAllEmails()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                    self.loading = false
                case .finished:
                    self.loading = false
                }
            } receiveValue: { emails in
                self.emails = emails
                self.openedEmail = emails.first
            }
            .store(in: &cancellables)
    }

    func setOpenedEmail(id: Int, isDetailOnlyOpen: Bool) {
        self.openedEmail = emails.first(where: { $0.id == id })
        self.isDetailOnlyOpen = isDetailOnlyOpen
    }

    func toggleSelectedEmail(id: Int) {
        if selectedEmails.contains(id) {
            selectedEmails.remove(id)
        } else {
            selectedEmails.insert(id)
        }
    }

    func closeDetailScreen() {
        self.isDetailOnlyOpen = false
        self.openedEmail = emails.first
    }
}
