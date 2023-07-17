//
//  CommonData.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/7/23.
//

import Foundation

class CommonData {
    
    // City List Data
    
    static var cityList: [CityData] {
        get {
            do {
                return try UserDefaults.standard.getCustomObject(forKey: KeyManager.weatherListDataKey, castTo: [CityData].self)
            } catch {
                return []
            }
        }
        set {
            do {
                try UserDefaults.standard.setCustomObject(newValue, forKey: KeyManager.weatherListDataKey)
            } catch {
                return
            }
        }
    }
    
    // City List Data
    
    static func getCityList() -> [CityData] {
        return cityList
    }
    
    static func appendCityList(data: CityData!) {
        var cityList = getCityList()
        cityList.append(data)
        CommonData.cityList = cityList
    }
    
    static func removeCityList(index: Int!) {
        var cityList = getCityList()
        cityList.remove(at: index)
        CommonData.cityList = cityList
    }
}
