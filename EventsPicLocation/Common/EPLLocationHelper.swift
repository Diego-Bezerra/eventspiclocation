//
//  EPLLocationHelper.swift
//  EventsPicLocation
//
//  Created by Cittati Tecnologia on 04/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import CoreLocation

class EPLLocationHelper: NSObject, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    static let sharedInstance = EPLLocationHelper()

    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        //manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

}
