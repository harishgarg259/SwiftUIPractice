//
//  Array.swift
//  Yappetizer
//
//  Created by Harish Garg on 18/06/24.
//

import Foundation

extension RandomAccessCollection {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}
