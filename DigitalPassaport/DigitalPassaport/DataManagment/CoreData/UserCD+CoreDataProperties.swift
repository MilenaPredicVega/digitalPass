//
//  UserEntity+CoreDataProperties.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 28.8.23..
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var image: String?
    @NSManaged public var lastName: String?
    @NSManaged public var passes: NSSet?

}

// MARK: Generated accessors for passes
extension UserEntity {

    @objc(addPassesObject:)
    @NSManaged public func addToPasses(_ value: PassEntity)

    @objc(removePassesObject:)
    @NSManaged public func removeFromPasses(_ value: PassEntity)

    @objc(addPasses:)
    @NSManaged public func addToPasses(_ values: NSSet)

    @objc(removePasses:)
    @NSManaged public func removeFromPasses(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
