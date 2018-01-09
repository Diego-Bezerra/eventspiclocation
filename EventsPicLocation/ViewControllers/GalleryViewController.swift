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
    
    var mediaList:Array<FileMediaInfo>!
    let cellIdentfier = "mediaCell"
    var lotteryId:Int64?
    var subjectId:Int64?
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = EPLHelper.localized(string: "GALLERY")
        noImagesTxt.isHidden = true
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibCell = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentfier)
        
        mediaList = Array<FileMediaInfo>()
        if mediaList.count == 0 {
            collectionView.isHidden = true
            noImagesTxt.isHidden = false
        }
    }
    
    func getFilesList(lotId:Int64?, subId:Int64?) {
        
        guard let mLotId = lotId, let mSubId = subId else {
            collectionView.isHidden = true
            noImagesTxt.isHidden = false
            return
        }
        
        mediaList = Array<FileMediaInfo>()
        
        let list = Media.query(["lottery" : mLotId, "subject" : mSubId]
            , sort: [["date" : "DESC"]]) as! [Media]
        for media in list {
            if let f = media.file {
                mediaList.append(f)
            }
        }
        
        collectionView.isHidden = mediaList.isEmpty
        noImagesTxt.isHidden = !mediaList.isEmpty
        collectionView.reloadData()
    }
    
    func setLotteryId(lotId:Int64?, andSubjectId subId:Int64?) {
        lotteryId = lotId
        subjectId = subId
        getFilesList(lotId: lotId, subId: subId)
    }
    
    public func reload() {
        guard let lotId = lotteryId, let subId = subjectId else {
            return
        }
        setLotteryId(lotId: lotId, andSubjectId: subId)
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
        
        let file = mediaList[indexPath.row]
        cell.setImage(file: file)
        
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
        if let fileName = mediaList[indexPath.row].name {
            let viewController = PhotoViewController(fileName: fileName)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
