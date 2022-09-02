//
//  BookTableViewCell.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import UIKit

import Then
import SnapKit

final class BookTableViewCell: UITableViewCell {
    
    // MARK: UIComponents
    private lazy var coverImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.closed.circle")
        $0.tintColor = .label
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .label
    }
    
    private lazy var authorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .secondaryLabel
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .secondaryLabel
    }
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        [
            coverImageView,
            titleLabel,
            authorLabel,
            descriptionLabel
        ].forEach {
            addSubview($0)
        }
        
        coverImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.0)
            $0.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            $0.width.height.equalTo(80.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.0)
            $0.leading.equalTo(coverImageView.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview().inset(12.0)
        }
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(12.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(5.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(12.0)
        }
    }
    
    func configureUI() {
        selectionStyle = .none
    }
    
    // MARK: configure Data
    func configureData(_ data: Book?) {
        guard let data = data else {
            return
        }
  
        coverImageView.loadWithURL(data.thumbnailURL)
        titleLabel.text = data.title
        authorLabel.text = data.authors.first
        descriptionLabel.text = data.description
    }
    
}
