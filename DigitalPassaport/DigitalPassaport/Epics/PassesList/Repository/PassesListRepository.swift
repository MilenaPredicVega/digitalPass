//
//  PassesListRepository.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation
import CoreData
import Combine

protocol PassesListRepository {
    func getPasses() -> AnyPublisher<[Pass], APIError>
}

class PassesListRepositoryImpl: PassesListRepository {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getPasses() -> AnyPublisher<[Pass], APIError> {
        coreDataManager.fetchPasses()
            .map { passEntities in
                passEntities.map { $0.toPass() }
            }
            .eraseToAnyPublisher()
    }
}
