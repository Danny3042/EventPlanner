//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation
import SwiftUI

struct Account {
    let id: Int
    let uid: Int
    let firstName: String
    let lastName: String
    let avatar: Image
    var isCurrentAccount: Bool
    
    init(id: Int, uid: Int, firstName: String, lastName: String, avatar: Image, isCurrentAccount: Bool = false) {
        self.id = id
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.isCurrentAccount = isCurrentAccount
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
