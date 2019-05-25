//
//  APIManger.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation

class APIManger {
    
    public static let instance = APIManger()
    
    private init() {}
    
    var apiKey : String {
        get{
            return "f219517316820aafdb86f1ef2a88000f"
        }
    }
    
    var baseURL : URL {
        get {
             guard let url = URL(string: "https://api.darksky.net/forecast/f219517316820aafdb86f1ef2a88000f/42.3601,-71.0589") else { fatalError() }
            return url
        }
    }
    
    func apiResponse(  _ complition : ((_ callback: [Forecast]?, _ err : Error?) -> Void)?) {
     

        URLSession.shared.dataTask(with: baseURL) { (data, _, err) in
            print("started")

            if err != nil {
                print(err)
                complition?(nil, err)
            }
            guard let data = data else { return }
            print(data)
            do {
                let decoder = try JSONDecoder().decode(Forecast.self, from: data)
                print(decoder)
                complition?([decoder], nil)
            } catch {
                print(error)
            }
            
        }.resume()
    
    
    }
}
