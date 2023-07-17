//
//  ApiManager.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/2/23.
//

import Foundation

class APIManager {
    
    struct APIKeys {
        static let openCage = "7239add17b104035b60277b451c7ca3b"
        static let openWeather = "a921fe0dcc416494329b0be384bd3f10"
    }
    
    struct Routs {
        static let citySearch = "https://api.opencagedata.com/geocode/v1/json?"
        static let currentWeather = "https://api.openweathermap.org/data/2.5/weather?"
        static let foreCast = "https://api.openweathermap.org/data/2.5/forecast?"
        
        static func weatherIcon(iconName: String) -> String! { return "https://openweathermap.org/img/wn/\(iconName)@2x.png" }
    }
    
    static func getFetchAPI<T:Decodable>(to urlString: String!, method: RequestMethod, header: [String: String]? = nil, param: Codable? = nil) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw WeatherAppError(ErrorManager.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        if let header = header {
            request.addHeader(header: header)
        }
        if let param = param {
            try request.addParam(param: param, method: method)
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        var decoded: T!
        
        do {
            decoded = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
        
        return decoded
    }
}
