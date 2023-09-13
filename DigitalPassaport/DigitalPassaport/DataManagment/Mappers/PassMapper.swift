//
//  PassMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation
import CoreData

extension Pass {
    func toEntity(in context: NSManagedObjectContext) -> PassEntity {
        let entity = PassEntity(context: context)
        entity.id = self.id
        entity.name = self.name
        entity.descriptionCD = self.description
        entity.icon = self.icon
        return entity
    }
}
