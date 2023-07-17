//
//  URLRequestExtensions.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/4/23.
//

import Foundation

extension URLRequest {
    
    mutating func addHeader(header: [String: String]!) {
        for (key, value) in header {
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    mutating func addParam(param: Codable, method: RequestMethod) throws {
        
        let encoded = try JSONEncoder().encode(param)
        
        if (method == .get) {
            var components = URLComponents(string: self.url!.absoluteString)
            var queryItems = [URLQueryItem]()
            let dic = try JSONSerialization.jsonObject(with: encoded, options: []) as! [String: String]
            for (key, value) in dic {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            components?.queryItems = queryItems
            self.url = components?.url
        } else {
            self.httpBody = encoded
        }
    }
}
