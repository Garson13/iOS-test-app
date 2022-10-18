//
//  TableVIewCell.swift
//  Ios test
//
//  Created by Гарик on 15.10.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var product: String?
    
   lazy var imagesView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var productName: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return view
    }()
    
    
    lazy var productDescription: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return view
    }()
    
    
    lazy var price: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.orange, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 5
        view.addArrangedSubview(productName)
        view.addArrangedSubview(productDescription)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "Cell")
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(verticalStackView)
        contentView.addSubview(price)
        contentView.addSubview(imagesView)

    }
    
    private func setupConstraints() {
        
        price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10).isActive = true
        price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20).isActive = true
        price.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor,constant: 10).isActive = true
        price.widthAnchor.constraint(equalToConstant: 90).isActive = true
        price.heightAnchor.constraint(equalToConstant: 35).isActive = true

        
        imagesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imagesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imagesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        imagesView.widthAnchor.constraint(equalToConstant: 150).isActive = true

        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: imagesView.trailingAnchor, constant: 20).isActive = true
    }
}
