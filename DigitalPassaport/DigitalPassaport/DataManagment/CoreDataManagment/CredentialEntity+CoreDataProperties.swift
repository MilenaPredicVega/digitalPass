//
//  CredentialEntity+CoreDataProperties.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 31.8.23..
//
//

import Foundation
import CoreData


extension CredentialEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CredentialEntity> {
        return NSFetchRequest<CredentialEntity>(entityName: "CredentialEntity")
    }

    @NSManaged public var type: String?
    @NSManaged public var expirationTime: Date?

}

extension CredentialEntity : Identifiable {

}
