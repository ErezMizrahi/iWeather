//
//  hourlyViewModel.swift
//  Weather
//
//  Created by hackeru on 01/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

struct hourlyViewModel : iViewModle {
    var day: String
    
    var tempHigh: Int
    
    var tempLow: Int
    
  
    var image: UIImage
    
    var time: String
    var temp : Int
    
    static func formate(_ date : Date) -> String {
        return "\(String(Calendar.current.component(.hour, from: date))):00"
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE"
//        return formatter.string(for: date) ?? ""
    }

}

extension hourlyViewModel {
    init?(forecastInfo : Currently) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecastInfo.time!))
        self.time = hourlyViewModel.formate(date)
        self.temp = Int(forecastInfo.temperature!)
        self.image = UIImage(named: forecastInfo.icon!) ?? UIImage()
        self.tempLow = 0
        self.tempHigh = 0
        self.day = ""
    }
}
