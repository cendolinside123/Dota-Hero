//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Jan Sebastian on 10/03/22.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var heroID: Int16
    @NSManaged public var name: String?

}
