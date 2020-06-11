//
//  ImageGalleryCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-07.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class ImageGalleryCell: BaseCollectionCell {
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 3.0
        sv.backgroundColor = .black
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func initializeCell() {
        super.initializeCell()
        
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0).isActive = true
    }
}

extension ImageGalleryCell: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                let ratio = min(ratioW, ratioH)
                
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                
                let horizontalInset = 0.5 * (newWidth * scrollView.zoomScale > imageView.frame.width ? (newWidth - imageView.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let verticalInset = 0.5 * (newHeight * scrollView.zoomScale > imageView.frame.height ? (newHeight - imageView.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
            }
        } else {
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}




