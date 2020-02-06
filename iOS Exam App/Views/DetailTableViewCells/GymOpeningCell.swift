//
//  GymOpeningCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-06.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class GymOpeningCell: BaseCell {
    
    var spaceDetails: SpaceDetails? {
        didSet {
            guard let spaceDetails = spaceDetails else { return }
            daysLabel.text = spaceDetails.openDays
            hoursLabel.text = spaceDetails.openHours
        }
    }
    
    private let daysLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .black
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let hoursLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .black
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(daysLabel)
        daysLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        daysLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        daysLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        daysLabel.sizeToFit()
        
        addSubview(hoursLabel)
        hoursLabel.topAnchor.constraint(equalTo: daysLabel.topAnchor, constant: 0).isActive = true
        hoursLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        hoursLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        hoursLabel.sizeToFit()
    }
    
}
