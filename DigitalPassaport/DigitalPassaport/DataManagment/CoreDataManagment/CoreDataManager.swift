////
////  CoreDataManager.swift
////  DigitalPassaport
////
////  Created by Milena Predic on 29.8.23..
////
//
import Foundation
import CoreData

class CoreDataManager {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveUserFromResponse(_ accountResponse: AccountResponse) {
        context.perform {
            let userEntity = accountResponse.user.toEntity(in: self.context)
        }
        do {
            try self.context.save()
        } catch {
            print("Error saving data to Core Data: \(error)")
        }
    }
    
    func savePassFromResponse(_ accountResponse: AccountResponse) {
        context.perform {
            for pass in accountResponse.passes {
                let passEntity = pass.toEntity(in: self.context)
            }
        }
        do {
            try self.context.save()
        } catch {
            print("Error saving data to Core Data: \(error)")
        }
    }
    
    func fetchPasses() -> [PassEntity] {
        let fetchRequest: NSFetchRequest<PassEntity> = PassEntity.fetchRequest()
        do {
            let passEntities = try context.fetch(fetchRequest)
            return passEntities
        } catch {
            print("Error fetching data from Core Data: \(error)")
            return []
        }
    }
    
    func fetchUser() -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let userEntities = try context.fetch(fetchRequest)
            return userEntities.first
        } catch {
            print("Error fetching data from Core Data: \(error)")
            return nil
        }
    }
    
    func clearCoreData() {
        let fetchRequestUser: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserEntity")
        let fetchRequestPass: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PassEntity")
        
        let deleteRequestUser = NSBatchDeleteRequest(fetchRequest: fetchRequestUser)
        let deleteRequestPass = NSBatchDeleteRequest(fetchRequest: fetchRequestPass)
        
        do {
            try context.execute(deleteRequestUser)
            try context.execute(deleteRequestPass)
            try context.save()
        } catch {
            print("Error clearing Core Data: \(error)")
        }
    }
}
