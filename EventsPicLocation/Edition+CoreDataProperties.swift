//
//  Edition+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import CoreData


extension Edition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Edition> {
        return NSFetchRequest<Edition>(entityName: "Edition")
    }

    @NSManaged public var id: Int64
    @NSManaged public var mDescription: String?

}
