//
//  ErrorManager.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/3/23.
//

import Foundation

struct WeatherAppError: LocalizedError {
    
    let description: String

    init(_ description: String) {
        self.description = description
    }

    var errorDescription: String? {
        description
    }
}

class ErrorManager {
    
    static let invalidURL = "Invalid URL"
    
    static func decodeFail(classType: String!) -> String! {
        return "Failed decoding to \(classType!)"
    }
}
