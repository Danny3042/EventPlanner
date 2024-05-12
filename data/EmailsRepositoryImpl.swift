//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 12/05/2024.
//

import Foundation
import Combine


class EmailsRepositoryImpl: EmailsRepository {
    func getAllEmails() -> AnyPublisher<[Email], Error> {
        // Replace with your actual implementation for fetching all emails
        return Just(LocalEmailsDataProvider.allEmails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getCategoryEmails(category: MailBoxType) -> AnyPublisher<[Email], Error> {
        // Replace with your actual implementation for fetching emails by category
        let categoryEmails = LocalEmailsDataProvider.allEmails.filter { $0.mailbox == category }
        return Just(categoryEmails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getAllFolders() -> [String] {
        // Replace with your actual implementation for fetching all folders
        return LocalEmailsDataProvider.getAllFolders()
    }

    func getEmailFromId(id: Int) -> AnyPublisher<Email?, Error> {
        // Replace with your actual implementation for fetching an email by id
        let email = LocalEmailsDataProvider.allEmails.first { $0.id == id }
        return Just(email)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
