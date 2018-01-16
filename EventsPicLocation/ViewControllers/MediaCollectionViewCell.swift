//
//  MediaCollectionViewCell.swift
//  EventsPicLocation
//
//  Created by Diego on 03/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import SDWebImage

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var checkedImg: UIImageView!
    @IBOutlet weak var alphaLayerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(file:FileMediaInfo) {
        if let path = file.name {
            if file.mimeType == FileMediaInfo.getMimeTypeStr(fileMimeType: FileMediaInfo.FileMimeType.Imagem) {
                setImage(imageView: self.mediaImage, fileName: path)
            } else if file.mimeType == FileMediaInfo.getMimeTypeStr(fileMimeType: FileMediaInfo.FileMimeType.Video) {
                let img = EPLHelper.thumbnailForVideoAtURL(url: EPLHelper.getFileURL(fileName: path))
                setImage(imageView: mediaImage, image: img)
            }
        }
    }
    
    private func setImage(imageView:UIImageView, image:UIImage?) {
        guard let img = image else {
            imageView.image = UIImage(named: "warning")
            return
        }
        imageView.image = img
    }
    
    private func setImage(imageView:UIImageView, fileName:String?) {
        
        guard let fName = fileName else {
            imageView.image = UIImage(named: "warning")
            return
        }
        
        //imageView.sd_setImage
        imageView.image = load(fileName: fName)
//        imageView.sd_setImage(with: url
//            , placeholderImage: imagePlaceHolder
//        , options: SDWebImageOptions.cacheMemoryOnly) { (image, error, cacheType, url) in
//            if error != nil {
//                imageView.image = UIImage(named: "warning")
//            }
//        }
    }
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func load(fileName:String) -> UIImage? {
        let fileURL = EPLHelper.getFileURL(fileName: fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
            UIImage(named: "warning")
        }
        return UIImage(named: "warning")
    }
}
