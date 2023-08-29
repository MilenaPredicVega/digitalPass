//
//  PassEntity+CoreDataProperties.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 28.8.23..
//
//

import Foundation
import CoreData


extension PassEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PassEntity> {
        return NSFetchRequest<PassEntity>(entityName: "PassEntity")
    }

    @NSManaged public var descriptionCD: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension PassEntity : Identifiable {

}
