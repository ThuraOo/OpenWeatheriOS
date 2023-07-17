//
//  SequenceExtensions.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/12/23.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
