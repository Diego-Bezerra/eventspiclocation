//
//  Media+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Diego on 08/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var mimeType: String?
    @NSManaged public var lottery: Int64
    @NSManaged public var subject: Int64
    @NSManaged public var file: FileMediaInfo?
    @NSManaged public var user: User?
    @NSManaged public var sync: Bool

}
