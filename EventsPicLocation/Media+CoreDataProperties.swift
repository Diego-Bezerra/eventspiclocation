//
//  Media+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var id: Int64
    @NSManaged public var date: NSDate?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var photos: NSObject?
    @NSManaged public var videos: NSObject?
    @NSManaged public var edition: Edition?
    @NSManaged public var lottery: Lottery?
    @NSManaged public var user: User?

}
