//
//  SyncCenter.swift
//  EventsPicLocation
//
//  Created by Diego on 10/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class SyncCenter {
    
    static func syncFile(media:Media) {
        if media.mimeType == FileMediaInfo.getMimeTypeStr(fileMimeType: FileMediaInfo.FileMimeType.Imagem) {
            syncFilePhoto(media: media)
        } else {
            syncFileVideo(media: media)
        }
    }
    
    static func syncFileVideo(media:Media) {
        
        if !EPLHelper.canUploadFiles() {
            return
        }
        
        let file = media.file!
        var url = EPLHelper.getFileURL(fileName: file.name!)
        url.appendPathExtension("MOV")
        
        do {
            let data = try Data(contentsOf: url)
            ApiService.saveFile(media: media, fileData: data, completion: { (isSuccess) in
                if isSuccess {
                    media.sync = true
                    media.save()
                    print("finalizado mídiaId: \(media.id)")
                }
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func syncFilePhoto(media:Media) {                
        
        if !EPLHelper.canUploadFiles() {
            return
        }
        
        let file = media.file!
        let url = EPLHelper.getFileURL(fileName: file.name!)
        
        do {
            let image = try UIImage(data: Data(contentsOf: url))
            if let img = image {
                if let imgData = UIImageJPEGRepresentation(img, 0.2) {
                    
                    ApiService.saveFile(media: media, fileData: imgData, completion: { (isSuccess) in
                        if isSuccess {
                            media.sync = true
                            media.save()
                            print("finalizado mídiaId: \(media.id)")
                        }
                    })
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func syncFiles() {
        
        if !EPLHelper.canUploadFiles() {
            return
        }
        
        let mediaList = Media.query(["sync" : false]) as! [Media]
        print(mediaList.count)
        for media:Media in mediaList {
            syncFile(media: media)
        }
        
    }
}
