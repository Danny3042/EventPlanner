//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation

protocol AccountsRepository {
    func getDefaultUserAccount() async throws -> Account
    func getAllUserAccount() async throws -> [Account]
    func getContactAccountByUid(uid: Int) async throws -> Account
}
