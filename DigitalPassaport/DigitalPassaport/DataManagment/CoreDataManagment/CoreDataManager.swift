//
//  CoreDataManager.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Combine
import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var credentialsChangesPublisher: CoreDataChangesPublisher<CredentialEntity>?
    private var cancellables: Set<AnyCancellable> = []
    
    private let context: NSManagedObjectContext
    
    private init() {
        self.context = CoreDataStack.shared.persistentContainer.viewContext
        
        let sortDescriptor = NSSortDescriptor(key: "expirationTime", ascending: true)

        self.credentialsChangesPublisher = CoreDataChangesPublisher(context: context, sortDescriptor: sortDescriptor)
         
        credentialsChangesPublisher?.changesPublisher
            .sink { credentials in
                // Ovde dobijate ažurirane Credentials iz CoreData
                print("Promenjeni Credentials: \(credentials)")
            }
            .store(in: &cancellables)
    }
    
    private func perform<T>(_ block: @escaping () throws -> T) -> AnyPublisher<T, APIError> {
        return Future<T, APIError> { promise in
            self.context.perform {
                do {
                    let result = try block()
                    promise(.success(result))
                } catch {
                    promise(.failure(error as! APIError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveUserFromResponse(_ accountResponse: AccountResponse) -> AnyPublisher<Void, APIError> {
        perform {
            _ = accountResponse.user.toEntity(in: self.context)
            try self.context.save()
        }
    }

    func savePassFromResponse(_ accountResponse: AccountResponse) -> AnyPublisher<Void, APIError> {
        perform {
            for pass in accountResponse.passes {
                _ = pass.toEntity(in: self.context)
            }
            try self.context.save()
        }
    }
    
    func saveCredentialFromResponse(_ credentialResponse: Credential) -> AnyPublisher<Void, APIError> {
        perform {
            _ = credentialResponse.self
            try self.context.save()
        }
    }

    func fetchPasses() -> AnyPublisher<[PassEntity], APIError> {
        perform {
            let fetchRequest: NSFetchRequest<PassEntity> = PassEntity.fetchRequest()
            let passEntities = try self.context.fetch(fetchRequest)
            return passEntities
        }
    }

    func fetchUser() -> AnyPublisher<UserEntity?, APIError> {
        perform {
            let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            let userEntities = try self.context.fetch(fetchRequest)
            return userEntities.first
        }
    }
    
    func fetchCredentials() -> AnyPublisher<[CredentialEntity], APIError> {
        perform {
            let fetchRequest: NSFetchRequest<CredentialEntity> = CredentialEntity.fetchRequest()
            let credentialsEntities = try self.context.fetch(fetchRequest)
            
            for credential in credentialsEntities {
                print("Type: \(credential.type ?? "Unknown"), Expiration: \(credential.expirationTime ?? Date())")
            }
            
            return credentialsEntities
        }
    }

    func clearCoreData() -> AnyPublisher<Void, APIError> {
        perform {
            let fetchRequestUser: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserEntity")
            let fetchRequestPass: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PassEntity")
            let fetchRequestCredential: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CredentialEntity")
            
            try self.context.execute(NSBatchDeleteRequest(fetchRequest: fetchRequestUser))
            try self.context.execute(NSBatchDeleteRequest(fetchRequest: fetchRequestPass))
            try self.context.execute(NSBatchDeleteRequest(fetchRequest: fetchRequestCredential))
            try self.context.save()
        }
    }
}

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        return container
    }()
}
