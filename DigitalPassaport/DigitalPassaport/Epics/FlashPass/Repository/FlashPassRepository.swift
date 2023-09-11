//
//  FlashPassRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//
import Foundation
import CoreData
import Combine

protocol FlashPassRepository {
    func getUser() -> AnyPublisher<User, APIError>
    func getCredentials() -> AnyPublisher<[Credential], APIError>
    
}

class FlashPassRepositoryImpl: FlashPassRepository {
    
    func getUser() -> AnyPublisher<User, APIError> {
        let user = CoreDataManager.shared.fetchUser()
            .map { userEntity in
                    guard let userEntity else {
                        return User(firstName: "", lastName: "", email: "", image: "")
                    }
                return userEntity.toUser()
                }
            .eraseToAnyPublisher()
        return user
    }
    
    func getCredentials() -> AnyPublisher<[Credential], APIError> {
        CoreDataManager.shared.fetchCredentials()
            .map { credentialsEntities in
                credentialsEntities.map { $0.toCredential() }
            }
            .eraseToAnyPublisher()
    }
}
