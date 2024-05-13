//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation
import SwiftUI

struct LocalAccountDataProvider {
    static let allUserAccounts: [Account] = [
        Account(id: 1, uid: 0, firstName: "Fred", lastName: "Smith", avatar: Image("avatar_10"), isCurrentAccount: true),
        Account(id: 2, uid: 0, firstName: "Bob", lastName: "Jones", avatar: Image("avatar_2")),
        Account(id: 3, uid: 0, firstName: "John", lastName: "Doe", avatar: Image("avatar_9"))
    ]
    
    static let allUserContactAccounts: [Account] = [
        Account(id: 4, uid: 1, firstName: "Tracy", lastName: "Alvarez", avatar: Image("avatar_1"))
        // add other contacts here
    ]
    
    static func getDefaultUserAccount() -> Account {
        return allUserAccounts.first!
    }
    
    static func isUserAccount(uid: Int) -> Bool {
        return allUserAccounts.contains { $0.uid == uid }
    }
    
    static func getContactAccountByUid(accountId: Int) -> Account? {
        return allUserContactAccounts.first(where: { $0.id == accountId }) ?? Account(id: 0, uid: 0, firstName: "", lastName: "", avatar: Image("avatar_0"), isCurrentAccount: false)
    }
}
