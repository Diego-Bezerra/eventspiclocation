//
//  SyncCenter.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 10/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import Foundation

class SyncCenter {
    
    static func syncFilePhotos() {
        let filesToSync = Media.query(["sync" : false]) as! [Media]
        syncFilePhotos(index: 0, filesToSync: filesToSync)
    }
    
    private static func syncFilePhotos(index:Int, filesToSync:[Media]) {
        
        var i = index
        if i < filesToSync.count {
            
            let media = filesToSync[i]
            let file = media.file!
            let url = EPLHelper.getFileURL(fileName: file.name!)
            
            do {
                let image = try UIImage(data: Data(contentsOf: url))
                if let img = image {
                    if let imgData = UIImageJPEGRepresentation(img, 0.2) {
                    
                        ApiService.saveFile(mediaId: media.id, imageData: imgData, completion: { (isSuccess) in
                            if isSuccess {
                                media.sync = true
                                media.save()
                            }
                            
                            i += 1
                            if i < filesToSync.count {
                                SyncCenter.syncFilePhotos(index: i, filesToSync: filesToSync)
                            }
                        })
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
