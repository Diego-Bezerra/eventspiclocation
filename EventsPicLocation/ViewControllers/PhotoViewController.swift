//
//  PhotoViewController.swift
//  EventsPicLocation
//
//  Created by Diego on 03/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    var fileName:String?
    
    init(fileName: String) {
        super.init(nibName: "PhotoViewController", bundle: nil)
        self.fileName = fileName
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setImage(imageView: self.imageView, fileName: self.fileName)
    }

    func setImage(imageView:UIImageView, fileName:String?) {
        
        guard let fName = fileName else {
            imageView.image = UIImage(named: "warning")
            return
        }
        
        let url = EPLHelper.getFileURL(fileName: fName)
        do {
            imageView.image = try UIImage(data: Data(contentsOf: url))
        } catch {
            let e = error
        }
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
