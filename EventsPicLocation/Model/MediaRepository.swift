//
//  File.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class MediaRepository {
    
    func createNewMedia(edition:Edition, lottery:Lottery, date:NSDate, lat:Double, lng:Double, photos:NSArray, videos:NSArray)  {
        if let media = Media.create() as? Media {
            media.edition = edition
            media.lottery = lottery
            media.date = date
            media.lat = lat
            media.lng = lng
            media.photos = photos
            media.videos = videos
            
            media.save()
        }
    }
    
}
