//
//  ForecastViewController.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UITableViewController {
    var forecastArray : [Forecast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let location = AppLocationTracker.shared.currentLocation{
            getData(with: location)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.locationUpdated, object: nil, queue: .main) { [weak self](_) in
            if let location = AppLocationTracker.shared.currentLocation{
                self?.getData(with: location)
            }
        }
    }
    
    private func getData(with location : CLLocation){
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        APIManger.instance.apiResponse(lat: lat, lon: lon){[weak self] (arr,err) in
            guard let strongSelf = self else { return }
            strongSelf.forecastArray = arr ?? []
            
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
            
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return forecastArray.first?.daily?.data?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastTableViewCell

        let daily = forecastArray[0].daily?.data?[indexPath.row]
        
        let date = Date(timeIntervalSince1970: Double((daily?.time)!))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let day = formatter.string(for: date)
        
        cell.dayLabel.text = day
        cell.tempLabel.text = "\(daily?.temperatureLow ?? 0)* - \(daily?.temperatureMax ?? 0)*"
        cell.forecastImageView.image = UIImage(named: (daily?.icon)!)
        return cell
    }
    

}
