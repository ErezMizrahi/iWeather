//
//  Forecast.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
// MARK: - Forecast
struct Forecast: Codable {
    let latitude, longitude: Double?
    let timezone: String?
    let currently: Currently?
    let minutely: Minutely?
    let hourly: Hourly?
    let daily: Daily?
    let flags: Flags?
    let offset: Int?
}

// MARK: - Currently
struct Currently: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let nearestStormDistance: Int?
    let precipIntensity, precipIntensityError, precipProbability: Double?
    let precipType: String?
    let temperature, apparentTemperature, dewPoint, humidity: Double?
    let pressure, windSpeed, windGust: Double?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let visibility : Double?
    let ozone: Double?
}



// MARK: - Daily
struct Daily: Codable {
    let summary: String?
    let icon: String?
    let data: [DailyDatum]?
}

// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let sunriseTime, sunsetTime: Int?
    let moonPhase, precipIntensity, precipIntensityMax: Double?
    let precipIntensityMaxTime: Int?
    let precipProbability: Double?
    let precipType: String?
    let temperatureHigh: Double?
    let temperatureHighTime: Int?
    let temperatureLow: Double?
    let temperatureLowTime: Int?
    let apparentTemperatureHigh: Double?
    let apparentTemperatureHighTime: Int?
    let apparentTemperatureLow: Double?
    let apparentTemperatureLowTime: Int?
    let dewPoint, humidity, pressure, windSpeed: Double?
    let windGust: Double?
    let windGustTime, windBearing: Int?
    let cloudCover: Double?
    let uvIndex, uvIndexTime: Int?
    let visibility, ozone, temperatureMin: Double?
    let temperatureMinTime: Int?
    let temperatureMax: Double?
    let temperatureMaxTime: Int?
    let apparentTemperatureMin: Double?
    let apparentTemperatureMinTime: Int?
    let apparentTemperatureMax: Double?
    let apparentTemperatureMaxTime: Int?
}

// MARK: - Flags
struct Flags: Codable {
    let sources: [String]?
    let nearestStation: Double?
    let units: String?
    
    enum CodingKeys: String, CodingKey {
        case sources
        case nearestStation = "nearest-station"
        case units
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let summary: String?
    let icon: String?
    let data: [Currently]?
}

// MARK: - Minutely
struct Minutely: Codable {
    let summary: String?
    let icon: String?
    let data: [MinutelyDatum]?
}

// MARK: - MinutelyDatum
struct MinutelyDatum: Codable {
    let time: Int?
    let precipIntensity, precipIntensityError, precipProbability: Double?
    let precipType: String?
}
