//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation

struct LocalEmailsDataProvider {
    static let threads = [
        Email(
            id: 8,
            sender: LocalAccountDataProvider.getContactAccountByUid(accountId: 13)!,
            recipients: [LocalAccountDataProvider.getDefaultUserAccount()],
            subject: "Your update on Google Play Store is live!",
            body: """
                Your update, 0.1.1, is now live on the Play Store and available for your alpha users to start testing.
                
                Your alpha testers will be automatically notified. If you'd rather send them a link directly, go to your Google Play Console and follow the instructions for obtaining an open alpha testing link.
            """,
            attachments: [],
            isImportant: false,
            isStarred: false,
            mailbox: .trash,
            createdAt: "3 hours ago",
            threads: []
        ),
        // Add other threads here
    ]

    static let allEmails = [
        Email(
            id: 0,
            sender: LocalAccountDataProvider.getContactAccountByUid(accountId: 9)!,
            recipients: [LocalAccountDataProvider.getDefaultUserAccount()],
            subject: "Package shipped!",
            body: """
                Cucumber Mask Facial has shipped.

                Keep an eye out for a package to arrive between this Thursday and next Tuesday. If for any reason you don't receive your package before the end of next week, please reach out to us for details on your shipment.

                As always, thank you for shopping with us and we hope you love our specially formulated Cucumber Mask!
            """,
            attachments: [],
            isImportant: true,
            isStarred: true,
            mailbox: .inbox,
            createdAt: "20 mins ago",
            threads: []
        ),
        // Add other emails here
    ]

    static func get(id: Int) -> Email? {
        return allEmails.first { $0.id == id }
    }
    // create a new, blank [Email]
    static func create() -> Email {
        return Email(
            id: Int(Date().timeIntervalSince1970),
            sender: LocalAccountDataProvider.getDefaultUserAccount(),
            recipients: [],
            subject: "Monthly hosting party",
            body: "I would like to invite everyone to our monthly event hosting party",
            attachments: [],
            isImportant: false,
            isStarred: false,
            mailbox: .inbox,
            createdAt: "Just now",
            threads: []
        )
    }
    
    // create a new [Email] that is a reply with the given [replyToId]
    static func createReplyTo(replyToId: Int) -> Email {
        guard let replyTo = get(id: replyToId) else {
            return create()
        }
        return Email(
            id: Int(Date().timeIntervalSince1970),
            sender: replyTo.recipients.first ?? LocalAccountDataProvider.getDefaultUserAccount(),
            recipients: [replyTo.sender] + replyTo.recipients,
            subject: replyTo.subject,
            body: "Responding to the above conversation.",
            attachments: [],
            isImportant: replyTo.isImportant,
            isStarred: replyTo.isStarred,
            mailbox: .inbox,
            createdAt: "Just now",
            threads: []
        )
    }
    // get a list of [EmailFolder]s by which [Email]s can be categorised
    static func getAllFolders() -> [String] {
        return [
            "Receipts",
            "Pine Elementary",
            "Taxes",
            "Vacation",
            "Mortgage",
            "Grocery coupons"
        ]
    }
}

