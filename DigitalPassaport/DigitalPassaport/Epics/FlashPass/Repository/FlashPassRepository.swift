//
//  FlashPassRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//
import Foundation
import CoreData

protocol FlashPassRepository {
    func getUser() -> User
}

class FlashPassRepositoryImpl: FlashPassRepository {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getUser() -> User {
        let user = coreDataManager.fetchUser()
        return user!
        // TODO: avoid force unwraping
    }
}
