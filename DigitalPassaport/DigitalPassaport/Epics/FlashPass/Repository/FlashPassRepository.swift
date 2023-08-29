//
//  FlashPassRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 28.8.23..
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
        let userCD = coreDataManager.fetchUser()
        let user = userCD.map { userCD in
            return DataMapper.mapUser(userCD: userCD)
        }
        return user!
        // TODO: avoid force unwraping 
    }
}

