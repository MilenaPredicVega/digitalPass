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
    
    func saveAccountResponse(_ accountResponse: AccountResponse) {
        context.perform {
            let userItem = UserEntity(context: self.context)
            userItem.firstName = accountResponse.user.firstName
            userItem.lastName = accountResponse.user.lastName
            userItem.image = accountResponse.user.image
            userItem.email = accountResponse.user.email
            
            for pass in accountResponse.passes {
                let passItem = PassEntity(context: self.context)
                passItem.id = pass.id
                passItem.name = pass.name
                passItem.descriptionCD = pass.description
                passItem.icon = pass.icon
            
                userItem.addToPasses(passItem)
            }
            do {
                try self.context.save()
            } catch {
                print("Error saving data to Core Data: \(error)")
            }
        }
    }
    
    func fetchPasses() -> [PassEntity] {
        let fetchRequest: NSFetchRequest<PassEntity> = PassEntity.fetchRequest()
        
        do {
             let passes = try self.context.fetch(fetchRequest)
             var uniquePasses: [PassEntity] = []
             var uniquePassNames: Set<String> = []
             
             for pass in passes {
                 if !uniquePassNames.contains(pass.name ?? "") {
                     uniquePassNames.insert(pass.name ?? "")
                     uniquePasses.append(pass)
                 }
             }
             return uniquePasses
        } catch {
            print("Error fetching passes: \(error)")
            return []
        }
    }
    
    func fetchUser() -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.fetchLimit = 1

        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
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
