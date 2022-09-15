//
//  UIImageView+.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/2/22.
//

import UIKit

extension UIImageView {
    func loadWithURL(_ urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
