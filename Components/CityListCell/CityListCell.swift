//
//  CityListCell.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

class CityListCell: UITableViewCell {
    
    @IBOutlet weak var lblCityName: UILabel!
    
    func setData(data: CityData!) {
        lblCityName.text = "\(data.name ?? "") (\(data.cityType ?? ""))"
    }
}
