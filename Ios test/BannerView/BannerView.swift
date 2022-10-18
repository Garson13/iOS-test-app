//
//  BannerView.swift
//  Ios test
//
//  Created by Гарик on 16.10.2022.
//

import UIKit

class BannerView: UIView, UICollectionViewDataSource {
    
    var arrayImage = [UIImage(named: "banner 1"), UIImage(named: "banner 2")]

    private lazy var bannerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width / 1.3, height: frame.height - 20)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .systemGray6
        view.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bannerView)
        setupConstraints()
        bannerView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        bannerView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.banner.image = arrayImage[indexPath.row]
        return cell
    }
    
    
   private func setupConstraints() {
       bannerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
       bannerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
       bannerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       bannerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
