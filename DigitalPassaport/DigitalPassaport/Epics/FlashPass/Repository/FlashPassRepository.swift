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
                    if let userEntity = userEntity {
                        let user = userEntity.toUser()
                        return user
                    } else {
                        return User(firstName: "", lastName: "", email: "", image: "")
                    }
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
