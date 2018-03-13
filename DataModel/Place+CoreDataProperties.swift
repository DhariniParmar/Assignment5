//
//  Place+CoreDataProperties.swift
//  Assignment5
//
//  Created by Student on 2018-03-13.
//  Copyright © 2018 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var placename: String?
    @NSManaged public var placelocation: String?
    @NSManaged public var rating: Float

}
