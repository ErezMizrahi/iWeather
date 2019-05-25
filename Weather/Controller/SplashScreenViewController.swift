//
//  SplashScreenViewController.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import CoreLocation

class SplashScreenViewController: UIViewController {
  
    let locationManger = CLLocationManager()
    var array = [Forecast]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate func splashMode() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.activityIndicator.stopAnimating()
            strongSelf.performSegue(withIdentifier: "startApp", sender: nil)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
         checkLocationServices()
          
            print("done")
            splashMode()
        
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startApp" {
            let destVC = (segue.destination as? UINavigationController)?.viewControllers.first as! ForecastViewController
            guard let location = sender as? CLLocationCoordinate2D else { return }
//            destVC.lat = location.latitude
//            destVC.lon = location.longitude
        }
    }
 
    private func setupLocationManger() {
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManger()
            checkLocationAutorization()
           
        }else {
            // handle errors
        }
    }
    
    private func checkLocationAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            if let location = locationManger.location?.coordinate{
            performSegue(withIdentifier: "startApp", sender: location)
            splashMode()
            }
        case .denied:
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            break
        default:
            break
        }
    }

}

extension SplashScreenViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
