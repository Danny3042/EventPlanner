//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 12/05/2024.
//

import Foundation
import Combine


protocol EmailsRepository {
    func getAllEmails() -> AnyPublisher<[Email], Error>
    func getCategoryEmails(category: MailBoxType) -> AnyPublisher<[Email], Error>
    func getAllFolders() -> [String]
    func getEmailFromId(id: Int) -> AnyPublisher<Email?, Error>
}
