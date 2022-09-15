//
//  ImageCacheManager.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/15/22.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
