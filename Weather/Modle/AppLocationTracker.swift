//
//  AppLocationTracker.swift
//  Weather
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import CoreLocation

extension Notification.Name{
    static var locationUpdated : Notification.Name{
        get{
            return Notification.Name("locationUpdated_notification")
        }
    }
}

protocol IAppLocationTracker {
    func startLocationDetection()
    func stopLocationDetection()
    
    var currentLocation : CLLocation? { get }
}

class AppLocationTracker : NSObject{
    
    static let shared : IAppLocationTracker = AppLocationTracker()
    
    private let locationManager : CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100 //meter
    }
    
    
}

extension AppLocationTracker : IAppLocationTracker{
    
    var currentLocation : CLLocation?{
        get{
            return locationManager.location
        }
    }
    
    func startLocationDetection() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            //TOOD: - Handle
            print("denied")
        }
        
        
    }
    
    func stopLocationDetection() {
        locationManager.stopUpdatingLocation()
    }
}

extension AppLocationTracker : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        startLocationDetection()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NotificationCenter.default.post(name: .locationUpdated, object: self)
    }
}
