//
//  BaseViewController.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/7/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    deinit {
        print("deinited \(self.className)")
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
    }
}
