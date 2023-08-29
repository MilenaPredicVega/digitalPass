//
//  PassesListRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation
import CoreData

protocol PassesListRepository {
    func getPasses() -> [Pass]
}

class PassesListRepositoryImpl: PassesListRepository {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getPasses() -> [Pass] {
        let passItemCDs = coreDataManager.fetchPasses()
        let passes = passItemCDs.map { passItemCD in
            return DataMapper.mapPass(passItemCD: passItemCD)
        }
        return passes
    }
}
