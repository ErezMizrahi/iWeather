//
//  Business-Logic.swift
//  Weather
//
//  Created by hackeru on 04/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation

protocol iWeatherBL {
    var arrayCount : Int {get}
    var viewModle : [iViewModle] { get }
}

struct DailyBL : iWeatherBL{
    var viewModle: [iViewModle] = []
    
    var arrayCount: Int {
        return viewModle.count
    }
    
}

struct HourlyBL : iWeatherBL{
    var viewModle: [iViewModle] = []

    var arrayCount: Int {
        return viewModle.count
    }
    
  
}

struct MinutelyBL : iWeatherBL {
    var viewModle: [iViewModle] = []

      var arrayCount: Int {
        return viewModle.count
    }
    

}
