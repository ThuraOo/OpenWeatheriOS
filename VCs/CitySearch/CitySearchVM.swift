//
//  CitySearchViewModel.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/4/23.
//

import Foundation

class CitySearchVM: BaseViewModel {
    
    var cityList: [CityData] = []
    
    var cityListUpdated : (() -> ()) = {}
    
    func searchCity(text: String!) {
        
        Task {
            do {
                let param = CityDataRequest(q: text, key: APIManager.APIKeys.openCage)
                let cityListResponse: CityDataResponse = try await APIManager.getFetchAPI(to: APIManager.Routs.citySearch, method: .get, param: param)
                self.cityList = cityListResponse.results?.filter{ $0.name != nil && $0.name != ""} ?? []
                DispatchQueue.main.async {
                    self.cityListUpdated()
                }
            } catch {
                self.errorRecieved(error)
            }
        }
    }
    
    func clearCity() {
        cityList = []
    }
    
    func addCityToUserDefaults(index: Int) {
        CommonData.appendCityList(data: self.cityList[index])
    }
}
