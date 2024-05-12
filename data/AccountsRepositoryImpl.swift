//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation


import Foundation

class AccountsRepositoryImpl: AccountsRepository {
    func getDefaultUserAccount() async throws -> Account {
        do {
            return try await LocalAccountDataProvider.getDefaultUserAccount()
        } catch {
            throw error
        }
    }

    func getAllUserAccount() async throws -> [Account] {
        do {
            return try await LocalAccountDataProvider.allUserAccounts
        } catch {
            throw error
        }
    }

    func getContactAccountByUid(uid: Int) async throws -> Account {
        do {
            return try await LocalAccountDataProvider.getContactAccountByUid(accountId: uid)
        } catch {
            throw error
        }
    }
}


