//
//  MainViewController.swift
//  EventsPicLocation
//
//  Created by Diego Bezerra Souza on 20/07/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import KYDrawerController

class MainViewController: UITabBarController {
    
    var mapViewController:UINavigationController!
    var mediaViewController:UINavigationController!
    var settingsViewController:UINavigationController!
    static let contextChangedNotification = "contextChangedNotification"
    static let lotteryParamKey = "lotKey"
    static let subjectParamKey = "subKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SyncCenter.syncFiles()
        setupTabBar()
    }
    
    override func loadView() {
        super.loadView()
        setupTabBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setupTabBar() {
        self.tabBar.isTranslucent = false
        self.mapViewController = setupTabViewController(viewController: MapViewController(), title: "MAP", image: "map")
        self.mediaViewController = setupTabViewController(viewController: MediaViewController(), title: "MEDIA", image: "photo")
        self.settingsViewController = setupTabViewController(viewController: SettingsViewController(), title: "SETTINGS", image: "settings")
        
        self.viewControllers = [mediaViewController, mapViewController, settingsViewController]
        self.selectedIndex = 0
        _ = self.mapViewController.view
    }
    
    func setupTabViewController(viewController: UIViewController, title:String, image:String) -> UINavigationController {
        viewController.tabBarItem = UITabBarItem(title: NSLocalizedString(title, comment: "")
            , image: UIImage(named:image), tag: 0)
        return UINavigationController(rootViewController: viewController)
    }
}
