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
    func getCredentials(selectedPass: Pass) -> AnyPublisher<[Credential], APIError>
    func observeCredentialsChanges() -> AnyPublisher<[Credential], Never>
}

class FlashPassRepositoryImpl: FlashPassRepository {
    
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = CoreDataManager.shared
    }
    
    
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
    
    func getCredentials(selectedPass: Pass) -> AnyPublisher<[Credential], APIError> {
        coreDataManager.fetchCredentials(for: selectedPass.id)
            .map { credentialsEntities in
                credentialsEntities.map { $0.toCredential() }
            }
            .eraseToAnyPublisher()
    }
    
    func observeCredentialsChanges() -> AnyPublisher<[Credential], Never> {
        coreDataManager.credentialsChangesPublisher.changesPublisher
             .receive(on: DispatchQueue.main)
             .map { $0.map { $0.toCredential()} }
             .eraseToAnyPublisher()
    }
}
