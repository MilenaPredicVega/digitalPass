//
//  PassEntity+CoreDataProperties.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 29.8.23..
//
//

import Foundation
import CoreData


extension PassEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PassEntity> {
        return NSFetchRequest<PassEntity>(entityName: "PassEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var descriptionCD: String?
    @NSManaged public var icon: String?

}

extension PassEntity : Identifiable {

}
