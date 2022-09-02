//
//  UIImageView+.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/2/22.
//

import UIKit

extension UIImageView {
    func loadWithURL(_ urlString: String){
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
