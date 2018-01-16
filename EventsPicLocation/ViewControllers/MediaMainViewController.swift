//
//  MediaMainViewController.swift
//  EventsPicLocation
//
//  Created by Diego on 27/12/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import ISHPullUp


class MediaMainViewController: ISHPullUpViewController, ISHPullUpSizingDelegate {
 
    var mediaViewController:MediaViewController!
    var galleryViewController:GalleryViewController!
    var navHeight:CGFloat!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = EPLHelper.localized(string: "MEDIA")
        self.view = UIView()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = false
        navHeight = 45
        mediaViewController = MediaViewController()
        galleryViewController = GalleryViewController()
        
        bottomViewController = UINavigationController(rootViewController: galleryViewController)
        contentViewController = mediaViewController
        sizingDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
    }
    
    //MARK: ISHPullUpSizingDelegate
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController
        , minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
        
        return self.navHeight
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
        return self.view.bounds.size.height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        return height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController contentVC: UIViewController) {
        
    }
}
