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
    var obj : Forecast?
    
    private init() {}
    
    var apiKey : String {
        get{
            return "f219517316820aafdb86f1ef2a88000f"
        }
    }
    
    var baseURL : URL {
        get {
             guard let url = URL(string: "https://api.darksky.net/forecast/f219517316820aafdb86f1ef2a88000f/") else { fatalError() }
            return url
        }
    }
    
    func apiResponse( lat : Double, lon : Double, _ complition : ((_ callback: Forecast?, _ err : Error?) -> Void)?) {
     
        guard let url = URL(string: "\(baseURL)\(lat),\(lon)" ) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in

            if let err = err {
                print(err.localizedDescription)
                complition?(nil, err)
                return
            }
            guard let data = data else { return }
            do {
                let decoder = try JSONDecoder().decode(Forecast.self, from: data)
                self.obj = decoder
                
                complition?(decoder, nil)
            } catch {
                print(error)
            }
            
        }.resume()
    
    
    }
    
    
}
