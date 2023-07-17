//
//  WeatherDetailVM.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/10/23.
//

import Foundation

class WeatherDetailVM: BaseViewModel {
    
    var cityData: CityData!
    var currentWeatherData: CurrentWeatherResponseData!
    var weatherCount: Int! = 0
    var weatherGroup: [[CurrentWeatherResponseData]] = [[]]
    
    var foreCastUpdated : (() -> ()) = {}
    
    func fetchForecastWeather(lat: Double!, lon: Double!) {
        
        Task {
            do {
                let param = CurrentWeatherRequest(lat: lat, lon: lon, appid: APIManager.APIKeys.openWeather, units: "metric")
                let data: ForecastData! = try await APIManager.getFetchAPI(to: APIManager.Routs.foreCast, method: .get, param: param)
                self.weatherCount = data.list?.count
                self.groupWeatherWithDate(weatherList: data.list ?? [])
                DispatchQueue.main.async {
                    self.foreCastUpdated()
                }
            } catch {
                print(error)
                self.errorRecieved(error)
            }
        }
    }
    
    func groupWeatherWithDate(weatherList: [CurrentWeatherResponseData]!) {
        let dates : [String]! = weatherList.map{ $0.dateDaily ?? "" }.filter{ $0 != ""}.unique()
        for date in dates {
            weatherGroup.append(weatherList.filter{ $0.dateDaily == date })
        }
        weatherGroup = weatherGroup.filter{ $0.count > 0 }
    }
}
