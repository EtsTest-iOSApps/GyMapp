//
//  GymEquipementCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-06.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class GymEquipmentCell: GymCollectionViewTableViewCell, UICollectionViewDataSource {
    
    var spaceDetails: SpaceDetails? {
        didSet {
            DispatchQueue.main.async {
                self.iconsCollectionView.reloadData()
            }
        }
    }
    
    private let equipmentCellId = "equipmentCellId"
    
    override func setupView() {
        super.setupView()
        iconsCollectionView.dataSource = self
        iconsCollectionView.delegate = self
        iconsCollectionView.register(GymIconCell.self, forCellWithReuseIdentifier: equipmentCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaceDetails?.equipments.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: equipmentCellId, for: indexPath) as! GymIconCell
        cell.iconTextLabel.text = spaceDetails?.equipments[indexPath.item] ?? "Nil"
        return cell
    }
}
