//
//  PhotoViewController.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 03/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    var imageUrlStr:String?
    
    init(imageUrlStr: String) {
        super.init(nibName: "PhotoViewController", bundle: nil)
        self.imageUrlStr = imageUrlStr
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        EPLHelper.setImage(imageView: self.imageView, url: self.imageUrlStr)
    }

    func setupScrollView() {
        self.scrollView.minimumZoomScale = 1;
        self.scrollView.maximumZoomScale = 6.0;
        self.scrollView.contentSize = self.imageView.frame.size;
        self.scrollView.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView;
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
}
