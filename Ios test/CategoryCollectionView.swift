//
//  CategoryScrollView.swift
//  Ios test
//
//  Created by Гарик on 16.10.2022.
//

import UIKit

class CategoryScrollView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layoutView = UICollectionViewFlowLayout()
        layoutView.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layoutView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
