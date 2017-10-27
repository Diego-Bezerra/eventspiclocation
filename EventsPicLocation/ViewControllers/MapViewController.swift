//
//  MapViewController.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 10/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: EPLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("MAP", comment: "")
        
        ApiService.getSubjectList { (list) in
            let l = list
            let n = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        setupGoogleMaps()
    }
    
    func setupGoogleMaps() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
