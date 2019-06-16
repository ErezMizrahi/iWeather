//
//  hourlyViewModel.swift
//  Weather
//
//  Created by hackeru on 01/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

struct hourlyViewModel : iViewModle {
    var title: String
    var image: UIImage
    var temp : (Int,Int)
    
    static func formate(_ date : Date) -> String {
        return "\(String(Calendar.current.component(.hour, from: date))):00"
    }

}

extension hourlyViewModel {
    init?(forecastInfo : Currently) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecastInfo.time!))
        self.title = hourlyViewModel.formate(date)
        self.temp = (Int(forecastInfo.temperature!),0)
        self.image = UIImage(named: forecastInfo.icon!) ?? UIImage()
    }
}
