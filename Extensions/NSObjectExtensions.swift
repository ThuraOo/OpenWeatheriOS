//
//  NSObjectExtensions.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//
import Foundation

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension Decodable {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    static var className: String {
        return String(describing: self)
    }
}
