//
//  IBDesignableCustomView.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

class IBDesignableCustomView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
         xibSetup()
    }

    func xibSetup() {
        guard let view = loadViewFromNib(for: self) else { return }
        view.frame = bounds
        addSubview(view)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }
}
