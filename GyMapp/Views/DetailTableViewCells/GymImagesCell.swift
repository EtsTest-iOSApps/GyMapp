//
//  GymImagesCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

protocol SelectedImageFromCollectionViewDelegate: class {
    func didSelectImageFromCollectionView(index: Int)
}

class GymImagesCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: SelectedImageFromCollectionViewDelegate?
    
    var spaceImagesUrls: [String]? {
        didSet {
            guard let imageUrls = spaceImagesUrls else { return }
            pageControl.numberOfPages = imageUrls.count
            
            DispatchQueue.main.async {
                self.imagesCollectionView.reloadData()
            }
        }
    }
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let imageCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCV.isPagingEnabled = true
        imageCV.showsHorizontalScrollIndicator = false
        imageCV.translatesAutoresizingMaskIntoConstraints = false
        imageCV.backgroundColor = .black
        return imageCV
    }()
    
    private let imageCellId = "imageCellId"
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = UIColor(white: 0.5, alpha: 0.5)
        return pc
    }()
    
    override func initializeCell() {
        super.initializeCell()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(GymImageCell.self, forCellWithReuseIdentifier: imageCellId)
        
        addSubview(imagesCollectionView)
        imagesCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imagesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imagesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        imagesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaceImagesUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! GymImageCell
        if let imageUrl = spaceImagesUrls?[indexPath.item] {
            cell.spaceImageView.loadImageUsingUrlString(urlString: imageUrl)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: frame.width, height: frame.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectImageFromCollectionView(index: indexPath.item)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / frame.width)
    }
    
}

fileprivate class GymImageCell: BaseCollectionCell {
    let spaceImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    override func initializeCell() {
        super.initializeCell()
        
        addSubview(spaceImageView)
        spaceImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        spaceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        spaceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        spaceImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
