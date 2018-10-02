//
//  MapViewController.swift
//  EventsPicLocation
//
//  Created by Diego on 10/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import UIKit
import GoogleMaps
import AVKit
import AVFoundation

class MapViewController: EPLBaseViewController, GMSMapViewDelegate{

    var mapView:GMSMapView?
    var selectedLottery:LotteryVO?
    var selectedSubject:SubjectVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("MAP", comment: "")
        self.loadObservers()
    }    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        setupGoogleMaps()
    }
    
    func loadObservers() {
        NotificationCenter.default.addObserver(self
            , selector: #selector(updateLocation)
            , name: NSNotification.Name(EPLLocationHelper.observerStr)
            , object: nil)
        
        NotificationCenter.default.addObserver(self
            , selector: #selector(self.updateContext(notification:))
            , name: NSNotification.Name(MainViewController.contextChangedNotification)
            , object: nil)
    }
    
    func setupGoogleMaps() {
        
        let lat = -10.002109
        let lng = -54.245793
        let zoom:Float = 5.0
        
        let camera = GMSCameraPosition.camera(withLatitude: lat
            , longitude: lng
            , zoom: zoom)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        mapView?.delegate = self
        self.view = mapView
    }
    
    func updateLocation() {
        
        guard let location = EPLLocationHelper.sharedInstance.getCurrentLocation() else {
            return
        }
        
        NotificationCenter.default.removeObserver(self
            , name: Notification.Name(EPLLocationHelper.observerStr)
            , object: nil)
        
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        let zoom:Float = 18.0            
        
        let camera = GMSCameraPosition.camera(withLatitude: lat
            , longitude: lng
            , zoom: zoom)
        self.mapView?.camera = camera
    }
    
    func updateContext(notification:Notification) {
        
        selectedLottery = notification.userInfo?[MainViewController.lotteryParamKey] as? LotteryVO
        selectedSubject = notification.userInfo?[MainViewController.subjectParamKey] as? SubjectVO
        guard let mLotId = selectedLottery?.id, let mSubId = selectedSubject?.id else {
            return
        }
        
        let list = MediaDAO.getMediaBy(lotteryId: mLotId, and: mSubId)
        let path = GMSMutablePath()
        for media:Media in list {
            createNewMarker(media: media)
            path.add(CLLocationCoordinate2DMake(media.lat, media.lng))
        }
        zoomOnMarkers(path:path)
    }
    
    func createNewMarker(media:Media) {
        let position = CLLocationCoordinate2D(latitude: media.lat, longitude: media.lng)
        let marker = GMSMarker(position: position)
        marker.userData = media
        marker.icon = UIImage(named: "clover_marker")
        marker.map = mapView
    }
    
    func zoomOnMarkers(path:GMSMutablePath) {
        let bounds = GMSCoordinateBounds(path: path)
        self.mapView?.animate(with: GMSCameraUpdate.fit(bounds))
    }
    
    //MARK: GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        guard let media = marker.userData as? Media, let fileName = media.file?.name else {
            return false
        }
        
        if media.mimeType == FileMediaInfo.getMimeTypeStr(fileMimeType: FileMediaInfo.FileMimeType.Imagem) {
            let viewController = PhotoViewController(fileName: fileName)
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            var url = EPLHelper.getFileURL(fileName: fileName)
            url.appendPathExtension("MOV")
            
            let playerViewController = AVPlayerViewController()
            let playerView = AVPlayer(url: url)
            playerViewController.player = playerView
            self.present(playerViewController,animated: true)
            playerViewController.player?.play()
        }
        
        return true
    }
}
