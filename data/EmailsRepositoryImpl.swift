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
        Future { promise in
            promise(.success(LocalEmailsDataProvider.allEmails))
        }
        .eraseToAnyPublisher()
    }

    func getCategoryEmails(category: MailBoxType) -> AnyPublisher<[Email], Error> {
        Future { promise in
            let categoryEmails = LocalEmailsDataProvider.allEmails.filter { $0.mailbox == category }
            promise(.success(categoryEmails))
        }
        .eraseToAnyPublisher()
    }

    func getAllFolders() -> [String] {
        return LocalEmailsDataProvider.getAllFolders()
    }

    func getEmailFromId(id: Int) -> AnyPublisher<Email?, Error> {
        Future { promise in
            let email = LocalEmailsDataProvider.allEmails.first { $0.id == id }
            promise(.success(email))
        }
        .eraseToAnyPublisher()
    }
}
