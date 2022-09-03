//
//  NSObject+.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
