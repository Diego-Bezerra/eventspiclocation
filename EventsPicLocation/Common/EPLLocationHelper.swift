//
//  EPLLocationHelper.swift
//  EventsPicLocation
//
//  Created by Diego on 04/01/18.
//  Copyright © 2018 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import CoreLocation

class EPLLocationHelper: NSObject, CLLocationManagerDelegate {
    
    private var locationManager:CLLocationManager!
    private var currentLocation:CLLocation?
    static let sharedInstance = EPLLocationHelper()
    static let observerStr = "updateLocation"

    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        self.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.startUpdatingLocation()
        }
    }
    
    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        NotificationCenter.default.post(name: NSNotification.Name(EPLLocationHelper.observerStr), object: nil)
        
        //print("user latitude = \(self.currentLocation?.coordinate.latitude)")
        //print("user longitude = \(self.currentLocation?.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

}
