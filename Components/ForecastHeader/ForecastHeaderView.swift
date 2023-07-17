//
//  ForecastHeaderView.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/12/23.
//

import Foundation
import UIKit

class ForecastHeaderView: UIView {
    
    @IBOutlet weak var lblDate: UILabel!
    
    func setup(date: String!) {
        lblDate.text = date
    }
}
