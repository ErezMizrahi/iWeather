//
//  DailyForecastTableViewCell.swift
//  Weather
//
//  Created by hackeru on 25/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//
//
import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    
    var viewModel : iViewModle! {
        didSet {
            if viewModel.temp.1 == 0{
                dayLabel.text = viewModel.title
                tempLabel.text = "\(viewModel.temp.0) ºƒ"
                forecastImageView?.image = viewModel.image
                
            }else {
                dayLabel.text = viewModel.title
                tempLabel.text = "\(viewModel.temp.0)-\(viewModel.temp.1)ºƒ"
                forecastImageView?.image = viewModel.image
                
            }
           
        }
    }
  
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        forecastImageView.clipsToBounds = true
    }

   

}
