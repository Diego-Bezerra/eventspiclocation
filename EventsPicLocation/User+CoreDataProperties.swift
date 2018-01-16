//
//  User+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Diego on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftRecord

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var login: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var active: Bool

}
