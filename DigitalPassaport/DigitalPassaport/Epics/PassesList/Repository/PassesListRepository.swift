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
        let passes = coreDataManager.fetchPasses()
        return passes.map { $0.toPass() }
    }
}
