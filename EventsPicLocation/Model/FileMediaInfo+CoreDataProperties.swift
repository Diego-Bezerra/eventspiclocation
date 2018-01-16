//
//  FileMediaInfo+CoreDataProperties.swift
//  EventsPicLocation
//
//  Created by Diego on 08/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//
//

import Foundation
import CoreData


extension FileMediaInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FileMediaInfo> {
        return NSFetchRequest<FileMediaInfo>(entityName: "FileMediaInfo")
    }
    
    @NSManaged public var mimeType: String?        
    @NSManaged public var name: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var syncDate: Date?

    enum FileMimeType {
        case Imagem, Video
    }
    
    static func getMimeTypeStr(fileMimeType:FileMimeType) -> String {
        switch fileMimeType {
        case .Imagem:
            return "image/jpeg"
        case .Video:
            return "video/mp4"
        }
    }
}
