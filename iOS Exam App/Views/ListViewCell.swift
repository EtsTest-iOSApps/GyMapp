//
//  ListViewCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import CoreLocation

class ListViewCell: UICollectionViewCell {
    
    var spaceDetails: SpaceDetails? {
        didSet {
            guard let spaceDetails = spaceDetails else { return }
            specificationLabel.text = "From $\(spaceDetails.rate)/HR · \(spaceDetails.squareFootage) SQ. FT. · Up to \(spaceDetails.maxCapacity) people"
            addressLabel.text = spaceDetails.name
            if let distanceFromUser = spaceDetails.distanceFromUser {
                distanceLabel.text = String(format: "%.2f", distanceFromUser) + " km away"
            } else {
                distanceLabel.text = "Distance not available"
            }
        }
    }
    
    let spaceImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let specificationLabel: UILabel = {
        let l = UILabel()
        l.text = "FROM $5/HR    580 SQ. FT.     UP TO 5 People"
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.sizeToFit()
        l.numberOfLines = 0
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let addressLabel: UILabel = {
        let l = UILabel()
        l.text = "2075 Robert-Bourassa Blvd"
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textColor = .black
        l.sizeToFit()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let distanceLabel: UILabel = {
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
        addSubview(specificationLabel)
        addSubview(addressLabel)
        addSubview(distanceLabel)
        
        spaceImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        spaceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        spaceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        spaceImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        specificationLabel.topAnchor.constraint(equalTo: spaceImageView.bottomAnchor, constant: 10).isActive = true
        specificationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        specificationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: specificationLabel.bottomAnchor, constant: 0).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        
        distanceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 0).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    }
}
