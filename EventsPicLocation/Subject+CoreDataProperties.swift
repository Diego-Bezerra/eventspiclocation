//
//  Subject+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Diego on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftRecord

extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var id: Int64
    @NSManaged public var mDescription: String?

}
