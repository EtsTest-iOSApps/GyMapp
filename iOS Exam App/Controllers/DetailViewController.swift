//
//  DetailViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellId = "cellId"
    
    var spaceDetail: SpaceDetails? {
        didSet {
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
    
    let detailTableView: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            let backButtonAppearence = UIBarButtonItemAppearance()
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            backButtonAppearence.normal.titleTextAttributes = titleTextAttributes
            backButtonAppearence.highlighted.titleTextAttributes = titleTextAttributes
            appearance.backButtonAppearance = backButtonAppearence
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
//        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(detailTableView)
        
        detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        if #available(iOS 11.0, *) {
            detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -185).isActive = true
        } else {
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -80).isActive = true
        }
    }
    

    
    private func setupTableView() {
        detailTableView.separatorColor = .clear
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderLabel()
        switch section {
        case 2:
            header.text = "Equipment"
        case 3:
            header.text = "Amenities"
        case 4:
            header.text = "Location"
        case 5:
            header.text = "Opening hours"
        default:
            let emptyView = UIView()
            emptyView.backgroundColor = .white
            emptyView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 0)
            return nil
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let gymImagesCell = GymImagesCell()
            return gymImagesCell
        case 1:
            let descriptionCell = GymDescriptionCell()
            descriptionCell.spaceDetails = spaceDetail
            return descriptionCell
        case 2:
            let equipementCell = GymEquipmentCell()
            equipementCell.spaceDetails = spaceDetail
            return equipementCell
        case 3:
            let amenitiesCell = GymAmenitiesCell()
            amenitiesCell.spaceDetails = spaceDetail
            return amenitiesCell
        case 4:
            let locationCell = GymLocationCell()
            locationCell.spaceDetails = spaceDetail
            return locationCell
        case 5:
            let openingCell = GymOpeningCell()
            openingCell.spaceDetails = spaceDetail
            return openingCell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return 250
        case 2, 3:
            return 100
        case 4:
            return 420
        default:
            return 40
        }
    }
    
    
    private class HeaderLabel: UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            text = "Title"
            font = UIFont.systemFont(ofSize: 18, weight: .bold)
            textColor = .black
            
        }
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            super.drawText(in: rect.inset(by: insets))
        }
    
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
