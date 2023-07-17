//
//  UserDefaultsExtensions.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/7/23.
//

import Foundation

extension UserDefaults {
    
    func setCustomObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        set(data, forKey: forKey)
    }
    
    func getCustomObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else {
            print("No data for key")
            throw WeatherAppError(ErrorManager.decodeFail(classType: "\(type.className)"))
        }
        let decoder = JSONDecoder()
        let object = try decoder.decode(type, from: data)
        return object
    }
}
