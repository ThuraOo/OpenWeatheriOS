//
//  WeatherListVM.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/4/23.
//

import Foundation

class WeatherListVM: BaseViewModel {
    
    var cityList: [CityData] { return CommonData.getCityList() }
    var weatherList: [CurrentWeatherResponseData] = []
    
    var weatherUpdated : (() -> ()) = {}
    var finishedFetching : (() -> ()) = {}
    
    func fetchCurrentWeather(lat: Double!, lon: Double!, index: Int!) {
        
        Task {
            do {
                let param = CurrentWeatherRequest(lat: lat, lon: lon, appid: APIManager.APIKeys.openWeather, units: "metric")
                let data: CurrentWeatherResponseData! = try await APIManager.getFetchAPI(to: APIManager.Routs.currentWeather, method: .get, param: param)
                weatherList[index] = data
                DispatchQueue.main.async {
                    self.weatherUpdated()
                    let hasFetchedTheLastOne = index == self.cityList.count - 1
                    if hasFetchedTheLastOne {
                        self.finishedFetching()
                    }
                }
            } catch {
                self.errorRecieved(error)
            }
        }
    }
    
    func fetchWeathersForIndividualCities() {
        
        if cityList.count == 0 {
            self.finishedFetching()
            return
        }
        
        for i in (0 ..< cityList.count) {
            if (i >= weatherList.count) {
                weatherList.append(CurrentWeatherResponseData())
                let data = cityList[i]
                fetchCurrentWeather(lat: data.lat, lon: data.lon, index: i)
            }
        }
    }
    
    func removeCity(index: Int) {
        CommonData.removeCityList(index: index)
    }
}
