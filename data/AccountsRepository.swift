//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 11/05/2024.
//

import Foundation
import Combine

protocol AccountsRepository {
    func getDefaultUserAccount() -> AnyPublisher<Account, Error>
    func getAllUserAccount() -> AnyPublisher<[Account], Error>
    func getContactAccountByUid(uid: Int) -> AnyPublisher<Account, Error>
}
