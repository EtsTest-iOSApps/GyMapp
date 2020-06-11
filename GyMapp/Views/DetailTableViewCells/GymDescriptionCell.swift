//
//  GymDescriptionCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-05.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class GymDescriptionCell: BaseCell {
    
    var spaceDetails: SpaceDetails? {
        didSet {
            guard let spaceDetails = spaceDetails else { return }
            let specificationText = "From $\(spaceDetails.rate)/HR · \(spaceDetails.squareFootage) SQ. FT. · Up to \(spaceDetails.maxCapacity) people"
            let addressText = spaceDetails.name
            let descriptionText = spaceDetails.description
            setupAttributeText(specificationText, addressText, descriptionText)
        }
    }
    
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.text = "Some text"
        l.textColor = .black
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func initializeCell() {
        super.initializeCell()
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupAttributeText(_ specifications: String, _ address: String, _ description: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "\n" + specifications + "\n", attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular), .foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: address + "\n\n", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)]))
        attributedText.append(NSAttributedString(string: description, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]))
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        descriptionLabel.attributedText = attributedText
    }
    
}
