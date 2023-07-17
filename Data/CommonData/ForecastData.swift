//
//  ForecastData.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/11/23.
//

import Foundation

struct ForecastData: Decodable {
    
    var list: [CurrentWeatherResponseData]?
}
