//
//  UINibExtensions.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

extension UINib {
    
    static func getNib(for name: String!) -> UINib {
        return UINib(nibName: name, bundle: nil)
    }
}
