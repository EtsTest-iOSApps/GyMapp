//
//  GymCollectionViewTableViewCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-05.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class GymCollectionViewTableViewCell: BaseCell, UICollectionViewDelegateFlowLayout {

    
    let iconsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let cellId = "cellId"
    
    override func initializeCell() {
        super.initializeCell()
        backgroundColor = .white
        
        addSubview(iconsCollectionView)
        iconsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        iconsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        iconsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        iconsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 100, height: 100)
        return size
    }
}


class GymIconCell: BaseCollectionCell {
    
    private let iconSize: CGFloat = 50
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.black.cgColor
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let iconTextLabel: UILabel = {
        let l = UILabel()
        l.text = "Water"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func initializeCell() {
        backgroundColor = .white
        
        addSubview(iconImageView)
        iconImageView.layer.cornerRadius = iconSize / 2
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        addSubview(iconTextLabel)
        iconTextLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4).isActive = true
        iconTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        iconTextLabel.sizeToFit()
        iconTextLabel.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }
    
}
