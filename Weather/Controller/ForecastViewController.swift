//
//  ForecastViewController.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    enum Mode {
        case daily
        case hourly
        case minutely
        
        var bl : iWeatherBL {
        
            var forecast = APIManger.instance.obj
            switch self {
            case .daily:
                let viewModel = forecast?.daily?.data?.compactMap(DailyForecastViewModle.init) ?? []
                return DailyBL(viewModle: viewModel)
            case .hourly:
                let viewModel = forecast?.hourly?.data?.compactMap(hourlyViewModel.init) ?? []
                return HourlyBL(viewModle: viewModel)
            case .minutely: return MinutelyBL()
            }
        }
    }
    
    var bl : iWeatherBL?
    
    func chooseMode (with mode : Mode){
        bl = nil
        self.tableView.reloadData()
        
        let newMode = mode.bl
        self.arrOfViewModles = newMode.viewModle
        

    }
    
    @IBOutlet weak var tableView: UITableView!
    var forecast : Forecast?
    var arrOfViewModles : [iViewModle] = [] {
        didSet {
            if arrOfViewModles.count > 0 {
            tableView.reloadData()
        }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        getLocation()
    }
   
    private func getLocation() {
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
        
        APIManger.instance.apiResponse(lat: lat, lon: lon){[weak self] (forecast,err) in
            guard let strongSelf = self else { return }
            let viewModel = forecast?.daily?.data?.compactMap(DailyForecastViewModle.init) ?? []

            strongSelf.forecast = forecast
            DispatchQueue.main.async {
                strongSelf.tableView.delegate = strongSelf
                strongSelf.tableView.dataSource = strongSelf
                
                strongSelf.arrOfViewModles = viewModel

            }
            
        }
    }

    
    @IBAction func userChoice(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:

            chooseMode(with: .daily)
            break
        case 1:

            chooseMode(with: .hourly)
            break
            
        default:
            break
        }
        
    }
    
}


extension ForecastViewController : UITableViewDelegate,UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return arrOfViewModles.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailyForecastTableViewCell
        let modle = arrOfViewModles[indexPath.row]

            cell.viewModel = modle

        
        return cell
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

