//
//  UserMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//

import Foundation
import CoreData

extension User {
    func toEntity(in context: NSManagedObjectContext) -> UserEntity {
        let entity = UserEntity(context: context)
        entity.firstName = self.firstName
        entity.lastName = self.lastName
        entity.image = self.image
        entity.email = self.email
        return entity
    }
}
