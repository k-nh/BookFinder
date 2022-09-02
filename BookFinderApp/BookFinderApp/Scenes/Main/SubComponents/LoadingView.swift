//
//  LoadingView.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/3/22.
//

import UIKit

import Then
import SnapKit

final class LoadingView: UIView {
    
    // MARK: UIComponents
    lazy var loadingIndicator = UIActivityIndicatorView().then {
        $0.style = .large
        $0.startAnimating()
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
