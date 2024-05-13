//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation
import Combine

class AccountsRepositoryImpl: AccountsRepository {
    func getDefaultUserAccount() -> AnyPublisher<Account, Error> {
        // Replace with your actual implementation for fetching the default user account
        return Just(LocalAccountDataProvider.getDefaultUserAccount())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getAllUserAccount() -> AnyPublisher<[Account], Error> {
        // Replace with your actual implementation for fetching all user accounts
        return Just(LocalAccountDataProvider.allUserAccounts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getContactAccountByUid(uid: Int) -> AnyPublisher<Account, Error> {
        // Replace with your actual implementation for fetching a contact account by uid
        let account = LocalAccountDataProvider.getContactAccountByUid(accountId: uid)
        return Just(account!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}


