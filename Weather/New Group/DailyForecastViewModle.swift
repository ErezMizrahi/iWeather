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
    var title : String{get}
    var temp : (Int,Int) {get}
}

struct DailyForecastViewModle : iViewModle {
    var temp: (Int,Int)
    var image: UIImage
    let title : String

  
    static func formate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(for: date) ?? ""
    }
    
    
}

extension DailyForecastViewModle {
    init?(forecastInfo : DailyDatum) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecastInfo.time!))
        self.title = DailyForecastViewModle.formate(date)
        self.image = UIImage(named: forecastInfo.icon!)!
        self.temp = (Int(forecastInfo.temperatureHigh!),Int(forecastInfo.temperatureLow!))
    }
}
