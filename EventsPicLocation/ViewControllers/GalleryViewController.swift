//
//  GalleryViewController.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 27/12/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var noImagesTxt: EPLLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var mediasList:Array<Media>!
    var mediaList:Array<String>!
    let cellIdentfier = "mediaCell"
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = EPLHelper.localized(string: "GALLERY")
        noImagesTxt.isHidden = true
        setupCollectionView()
    }

    func setupCollectionView() {
        //mediasList = Array<Media>()
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibCell = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentfier)
        
        mediaList = Array<String>()
        if mediaList.count == 0 {
            collectionView.isHidden = true
            noImagesTxt.isHidden = false
        }
//        mediaList.append("https://cdn.vox-cdn.com/uploads/chorus_asset/file/9224559/3DS_MetroidSamusReturns_char_01.jpg")
//        mediaList.append("http://vignette4.wikia.nocookie.net/metroid/images/b/ba/Metroid.jpg/revision/latest/scale-to-width-down/2000?cb=20150702055904")
//        mediaList.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUP1mooxxuItuHz2f-yvTH-YA3CGbeVo8wmboDatT9D1DEFZUW")
//        mediaList.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6tlDoeqGjDxGLIf_96AeKQhUjSc5hCh_wuqF2EU8JwS9q_We1")
//        mediaList.append("https://vignette.wikia.nocookie.net/metroid/images/1/1d/Metroid_Est%C3%A1ndar_en_Super_Metroid.png/revision/latest?cb=20110409195642&path-prefix=es")
//        mediaList.append("https://res.cloudinary.com/teepublic/image/private/s--e2-gYAJd--/t_Preview/b_rgb:191919,c_limit,f_auto,h_313,q_90,w_313/v1499099272/production/designs/1710662_1")
//        mediaList.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQALctmFKuUEDO9kDnfEXOtOcGK9aPBXkEEzmrtoIwsWahGz7I")
//        mediaList.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGRpYGt0hguTY7Ru-7c_9KVAwk48OCd8d_t5KkuCi6iTBqcZ5v")
//        mediaList.append("https://vignette.wikia.nocookie.net/metroid/images/0/06/Super_Metroid_title.png/revision/latest?cb=20120817181754")
//        mediaList.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlAGcVz8TIUqFkCuh1kcLZCa5T1vTaeMkKPlgSdGuKafniUkKR")
//        mediaList.append("https://gamersplash.files.wordpress.com/2017/05/switch-metroid-1.jpg?w=1200")
    }
    
    public func addImageToGallery(path:String) {
        collectionView.isHidden = false
        noImagesTxt.isHidden = true
        mediaList.append(path)
        collectionView.reloadData()
    }
    
    //MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MediaCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentfier, for: indexPath) as? MediaCollectionViewCell
        
        let mediaStr = mediaList[indexPath.row]
        cell.setImage(urlStr: mediaStr)
        
        return cell
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
     //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = mediaList[indexPath.row]
        let viewController = PhotoViewController(imageUrlStr: url)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
