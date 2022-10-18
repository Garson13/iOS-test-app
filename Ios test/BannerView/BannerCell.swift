//
//  CategoryCell.swift
//  Ios test
//
//  Created by Гарик on 16.10.2022.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    lazy var banner: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(banner)
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        banner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        banner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        banner.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        banner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
}
