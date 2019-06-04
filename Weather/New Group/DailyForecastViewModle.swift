//
//  DailyForecastViewModle.swift
//  Weather
//
//  Created by hackeru on 01/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
protocol iViewModle {
    var image: UIImage {get}
    
    var day : String{get}
    var tempHigh : Int{get}
    var tempLow : Int{get}
    var time: String{get}
    var temp : Int{get}
}

struct DailyForecastViewModle : iViewModle {
    var time: String
    
    var temp: Int
    
   static func formate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(for: date) ?? ""
    }
    
    var image: UIImage
    
    let day : String
    let tempHigh : Int
    let tempLow : Int
  
    
    
}

extension DailyForecastViewModle {
    init?(forecastInfo : DailyDatum) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecastInfo.time!))
        self.day = DailyForecastViewModle.formate(date)
        self.tempHigh = Int(forecastInfo.temperatureHigh!)
        self.tempLow = Int(forecastInfo.temperatureLow!)
        self.image = UIImage(named: forecastInfo.icon!)!
        self.time = ""
        self.temp = 0
    }
}
