//
//  GalleryViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-07.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var selectedIndex: Int?
    
    var spaceImagesUrls: [String]? {
        didSet {
            DispatchQueue.main.async {
                self.imageCollectionView.reloadData()
            }
            
        }
    }
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        return pc
    }()
    
    private let cellId = "cellId"
    private var didScroll = false
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .clear
        let image = #imageLiteral(resourceName: "BackButtonIcon")
        b.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        b.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    func canRotate() {}
    
    private func setupCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageGalleryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(imageCollectionView)
        view.addSubview(backButton)
        if #available(iOS 11.0, *) {
            imageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            imageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            imageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            imageCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        } else {
            imageCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            imageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        }
        
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    @objc private func handleBackButton() {
        dismiss(animated: true, completion: nil)
    }
}


extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaceImagesUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageGalleryCell
        cell.imageView.loadImageUsingUrlString(urlString: spaceImagesUrls?[indexPath.item] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if #available(iOS 11.0, *) {
            let size = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
            return size
        }
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        return size
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !didScroll {
            guard let selectedIndex = selectedIndex else { return }
            let indexToScrollTo = IndexPath(item: selectedIndex, section: 0)
            imageCollectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            didScroll = true
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
}
