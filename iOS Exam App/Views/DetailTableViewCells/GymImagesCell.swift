//
//  GymImagesCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class GymImagesCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let imageCellId = "imageCellId"
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let imageCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCV.translatesAutoresizingMaskIntoConstraints = false
        imageCV.backgroundColor = .black
        return imageCV
    }()
    
    override func setupView() {
        backgroundColor = .red
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(GymImageCell.self, forCellWithReuseIdentifier: imageCellId)
        
        addSubview(imagesCollectionView)
        imagesCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imagesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imagesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        imagesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: frame.width, height: frame.height)
        return size
    }
    
    
}

fileprivate class GymImageCell: UICollectionViewCell {
    let spaceIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .orange
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spaceIV)
        spaceIV.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        spaceIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        spaceIV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        spaceIV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
