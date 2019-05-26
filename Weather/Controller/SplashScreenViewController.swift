//
//  SplashScreenViewController.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
  
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

        AppLocationTracker.shared.startLocationDetection()
        splashMode()
        
    }
    


}
