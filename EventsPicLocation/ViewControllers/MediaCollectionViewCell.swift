//
//  MediaCollectionViewCell.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 03/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import SDWebImage

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(urlStr:String) {
        EPLHelper.setImage(imageView: self.mediaImage, url: urlStr)
    }
}
