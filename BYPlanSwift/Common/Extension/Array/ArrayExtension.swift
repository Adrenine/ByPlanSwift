//
//  Array+Extension.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/20.
//  Copyright © 2020 kystar. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
 
    mutating func removeFirst(object: Element) {
        if let index=firstIndex(of: object) {
            remove(at: index)
        }
    }
}

extension Array {
    func myMap<E>(_ transform: (Element) -> E) -> [E] {
        var mapped = [E]()
        for e in self {
            mapped.append(transform(e))
        }
        return mapped
    }
}

