//
//  MediaDAO.swift
//  EventsPicLocation
//
//  Created by Diego Tecnologia on 16/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class MediaDAO {
    
    static func saveMediaCore(mediaId:Int64, fileName:String, withRequest media:MediaRequestVO) -> Media {
        let mediaCore = Media.findOrCreate(["id" : mediaId]) as! Media
        mediaCore.date = media.dataHora
        mediaCore.id = mediaId
        mediaCore.lat = media.latitude ?? 0
        mediaCore.lng = media.longitude ?? 0
        mediaCore.file = saveFileMediaInfo(fileName: fileName, mimeType: media.mimeType ?? "")
        mediaCore.mimeType = media.mimeType
        mediaCore.lottery = media.idSorteio ?? 0
        mediaCore.subject = media.idAssunto ?? 0
        mediaCore.sync = false
        mediaCore.save()
        
        return mediaCore
    }
    
    static func saveFileMediaInfo(fileName:String, mimeType:String) -> FileMediaInfo? {
        if let fileMediaInfo = FileMediaInfo.findOrCreate(["name" : fileName]) as? FileMediaInfo {
            fileMediaInfo.creationDate = Date()
            fileMediaInfo.name = fileName
            fileMediaInfo.mimeType = mimeType
            fileMediaInfo.save()
            
            return fileMediaInfo
        }
        
        return nil
    }

    static func getMediaBy(lotteryId:Int64, and subjecId:Int64) -> [Media] {
        return Media.query(["lottery" : lotteryId, "subject" : subjecId]
            , sort: [["date" : "DESC"]]) as! [Media]
    }
}
