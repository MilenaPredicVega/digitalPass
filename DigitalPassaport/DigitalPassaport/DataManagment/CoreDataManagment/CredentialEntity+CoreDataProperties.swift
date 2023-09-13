//
//  CredentialEntity+CoreDataProperties.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 13.9.23..
//
//

import Foundation
import CoreData


extension CredentialEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CredentialEntity> {
        return NSFetchRequest<CredentialEntity>(entityName: "CredentialEntity")
    }

    @NSManaged public var expirationTime: Date?
    @NSManaged public var passID: UUID?
    @NSManaged public var type: String?

}

extension CredentialEntity : Identifiable {

}
