//
//  WeatherListRouter.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/11/23.
//

import Foundation
import UIKit

class WeatherListRouter {
    
    var viewController : WeatherListVC!
    var vm : WeatherListVM!
    
    func goToAddCity() {
        let vc = StoryboardManager.citySearchVC as! CitySearchVC
        vc.addedCity = { [weak self] in
            self?.viewController.searchWeather()
            self?.viewController.tableView.reloadData()
        }
        viewController.present(vc, animated: true)
    }
    
    func goToDetails(index: Int!) {
        let vc = StoryboardManager.weatherDetailVC as! WeatherDetailVC
        vc.vm.currentWeatherData = vm.weatherList[index]
        vc.vm.cityData = vm.cityList[index]
        vc.cityListIndex = index
        viewController.present(vc, animated: true)
    }
}
