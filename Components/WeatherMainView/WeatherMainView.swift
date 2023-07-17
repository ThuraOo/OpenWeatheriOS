//
//  WeatherMainView.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 5/31/23.
//

import UIKit

@IBDesignable class WeatherMainView: IBDesignableCustomView {
    
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWeatherDesc: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    func setupData(cityData: CityData!, weatherData: CurrentWeatherResponseData!) {
        
        lblCityName.text = "\(cityData.name ?? "")"
        lblTemp.text = weatherData.temp != nil ? "\(weatherData.temp ?? 0)°C" : "-"
        lblWeatherDesc.text = weatherData?.description?.capitalized ?? ""
        
        if let iconName = weatherData.icon?.replacingOccurrences(of: "n", with: "d", options: .literal, range: nil), iconName != "" {
            let urlString = APIManager.Routs.weatherIcon(iconName: iconName)
            imgWeather.setWebImage(urlString: urlString)
        }
    }
}
