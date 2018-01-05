//
//  Media+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftRecord

extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int64
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var file: String?
    @NSManaged public var mimeType: String?
    @NSManaged public var subject: Subject?
    @NSManaged public var lottery: Lottery?
    @NSManaged public var user: User?

}
