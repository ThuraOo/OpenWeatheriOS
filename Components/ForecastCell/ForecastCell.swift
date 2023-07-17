//
//  ForecastCell.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/10/23.
//

import Foundation
import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var lblWeatherDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    
    func setupData(weatherData: CurrentWeatherResponseData!) {
        
        lblWeatherDesc.text = weatherData.description?.capitalized ?? ""
        lblTemp.text = weatherData.temp != nil ? "\(weatherData.temp ?? 0)°C" : "-"
        lblDate.text = weatherData.dateHourly ?? ""
        
        if let iconName = weatherData.icon?.replacingOccurrences(of: "n", with: "d", options: .literal, range: nil), iconName != "" {
            let urlString = APIManager.Routs.weatherIcon(iconName: iconName)
            imgWeather.setWebImage(urlString: urlString)
        }
    }
}
