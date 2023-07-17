//
//  StoryboardManager.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

class StoryboardManager {
    
    class var weatherListVC: UIViewController { return UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: WeatherListVC.className) }
    class var weatherDetailVC: UIViewController { return UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: WeatherDetailVC.className) }
    class var citySearchVC: UIViewController { return UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: CitySearchVC.className) }
}
