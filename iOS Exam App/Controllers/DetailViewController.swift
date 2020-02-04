//
//  DetailViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let cellId = "cellId"
    let imageCV = ImageCollectionView()
    
    private let detailScrollView = DetailScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCV.delegate = self
        imageCV.dataSource = self
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .blue
        
        
        view.addSubview(detailScrollView)
        detailScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        detailScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        detailScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        detailScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCV.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
}
