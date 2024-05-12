//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation

struct LocalAccountDataProvider {
    static let allUserAccounts: [Account] = [
        Account(id: 1, uid: 0, firstName: "Fred", lastName: "Smith", avatar: 10, isCurrentAccount: true),
        Account(id: 2, uid: 0, firstName: "Bob", lastName: "Jones", avatar: 2),
        Account(id: 3, uid: 0, firstName: "John", lastName: "Doe", avatar: 9)
        
    ]
    
    static let allUserContactAccounts: [Account] = [
        Account(id: 4, uid: 0, firstName: "Tracy", lastName: "Alvarez", avatar: 1),
        // add other contacts here
    ]
    
    static func getDefaultUserAccount() -> Account {
        return allUserAccounts.first!
    }
    
    static func isUserAccount(uid: Int) -> Bool {
        return allUserAccounts.contains { $0.uid == uid }
    }
    
    static func getContactAccountByUid(accountId: Int) -> Account {
        return allUserContactAccounts.first { $0.uid == accountId }!
    }
}
