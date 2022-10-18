//
//  CategoryCell.swift
//  Ios test
//
//  Created by Гарик on 16.10.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    lazy var title: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .orange
        view.font = UIFont.systemFont(ofSize: 13)
        view.center = center
        return view
    }()
    
    lazy var name: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .orange
        view.layer.cornerRadius = 18
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.orange.cgColor
        view.addSubview(title)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(name)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        title.centerXAnchor.constraint(equalTo: name.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: name.centerYAnchor).isActive = true

        
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
}
