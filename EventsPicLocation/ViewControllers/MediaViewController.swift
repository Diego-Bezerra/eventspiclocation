//
//  MediaViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 23/09/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import DownPicker

class MediaViewController: UIViewController {
    
    @IBOutlet weak var edition: EPLTextField!
    @IBOutlet weak var event: UITextField!
    @IBOutlet weak var mediaContainer: UIView!
    
    var editionDowPicker:DownPicker!

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func openCameraViewAction(_ sender: Any) {
    }

    func getListOfEditions() -> Array<String>? {
        return nil
    }
    
    func setupDownPickers() {
        
    }

}
