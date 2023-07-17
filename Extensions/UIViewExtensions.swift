//
//  UIViewExtension.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

extension UIView {
    
    func loadViewFromNib(for view: UIView) -> UIView? {
        let view = UINib(nibName: view.className, bundle: Bundle(for: type(of: view))).instantiate(withOwner: self).first as? UIView
        return view
    }
}
