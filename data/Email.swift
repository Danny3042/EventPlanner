//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation

struct Email: Identifiable {
    let id: Int
    let sender: Account
    let recipients: [Account]
    let subject: String
    let body: String
    let attachments: [EmailAttachment]
    var isImportant: Bool
    var isStarred: Bool
    var mailbox: MailBoxType
    var createdAt: String
    let threads: [Email]
}
