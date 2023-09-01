//
//  CredentialMapper.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 31.8.23..
//

import Foundation
import CoreData

extension Credential {
    func toEntity(in context: NSManagedObjectContext) -> CredentialEntity {
        let entity = CredentialEntity(context: context)
        entity.type = self.type
        entity.expirationTime = self.expirationTime
        return entity
    }
}
