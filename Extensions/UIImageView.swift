//
//  UIImageView.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/10/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setWebImage(urlString: String!) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}
