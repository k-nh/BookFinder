//
//  Array+.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/11/22.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
