//
//  WeatherMainCell.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 5/31/23.
//

import Foundation
import UIKit

class WeatherMainCell: UITableViewCell {
    
    @IBOutlet weak var weatherView: WeatherMainView!
    
    func highLightView() {
        weatherView.bgView.isHidden = false
    }
    
    func unhighLightView() {
        weatherView.bgView.isHidden = true
    }
    
    func setupData(cityData: CityData!, weatherData: CurrentWeatherResponseData!) {
        weatherView.setupData(cityData: cityData, weatherData: weatherData)
    }
}
