//
//  CityData.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/3/23.
//

import Foundation

struct CityDataRequest: Codable {
    
    var q: String
    var key: String
    
    init(q: String, key: String) {
        self.q = q
        self.key = key
    }
}

struct CityDataResponse: Decodable {
    
    var results: [CityData]?
}

struct CityData: Codable {
    
    var flag: String?
    var components: CityComponentData?
    var geometry: CityGeometryData?
    
    var name: String? { return components?.city }
    var cityType: String? { return components?.cityType }
    var country: String? { return components?.country }
    var lat: Double? { return geometry?.lat }
    var lon: Double? { return geometry?.lng }
    
    private enum CodingKeys: String, CodingKey {
        case flag
        case components
        case geometry
    }
}

struct CityComponentData: Codable {
    
    var city: String?
    var cityType: String?
    var country: String?
    
    private enum CodingKeys: String, CodingKey {
        case cityType = "_type"
        case city
        case country
    }
}

struct CityGeometryData: Codable {
    
    var lat: Double?
    var lng: Double?
}
