//
//  ListViewCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class ListViewCell: UICollectionViewCell {
    
    let spaceImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let detailLabel: UILabel = {
        let l = UILabel()
        l.text = "FROM $5/HR    580 SQ. FT.     UP TO 5 People"
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.sizeToFit()
        l.numberOfLines = 0
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let addressLabel: UILabel = {
        let l = UILabel()
        l.text = "2075 Robert-Bourassa Blvd"
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.textColor = .black
        l.sizeToFit()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let distanceLabel: UILabel = {
        let l = UILabel()
        l.text = "2.78 km away"
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.sizeToFit()
        l.numberOfLines = 0
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let margin: CGFloat = 15
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(spaceImageView)
        addSubview(detailLabel)
        addSubview(addressLabel)
        addSubview(distanceLabel)
        
        spaceImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        spaceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        spaceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        spaceImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        detailLabel.topAnchor.constraint(equalTo: spaceImageView.bottomAnchor, constant: 10).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 0).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        
        distanceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 0).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    }
    
}
