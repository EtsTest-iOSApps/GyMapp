//
//  DetailScrollView.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class DetailScrollView: UIScrollView {
    
    let imageCollectionView = ImageCollectionView()
    
    let descriptionTextLabel: UILabel = {
        let l = UILabel()
        l.text = "bla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \nbla bla bla bla bla bla bla blabla \n"
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentSize = CGSize(width: frame.width, height: 1000)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    private func setupView() {
        
        backgroundColor = .yellow
        
        addSubview(imageCollectionView)
        imageCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        imageCollectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        
        addSubview(descriptionTextLabel)
        descriptionTextLabel.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 0).isActive = true
        descriptionTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        descriptionTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
