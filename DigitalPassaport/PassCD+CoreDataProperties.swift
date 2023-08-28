//
//  PassCD+CoreDataProperties.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 28.8.23..
//
//

import Foundation
import CoreData


extension PassCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PassCD> {
        return NSFetchRequest<PassCD>(entityName: "PassCD")
    }

    @NSManaged public var descriptionPass: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension PassCD : Identifiable {

}
