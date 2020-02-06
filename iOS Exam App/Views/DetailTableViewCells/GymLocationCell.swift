//
//  GymLocationCell.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-06.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import MapKit

class GymLocationCell: BaseCell {
    
    var spaceDetails: SpaceDetails? {
        didSet {
            guard let spaceDetails = spaceDetails else { return }
            centerMapOnGymLocation(spaceDetails)
            addressLabel.text = spaceDetails.address
        }
    }
    
    private let fixedMapView: MKMapView = {
        let mv = MKMapView()
        mv.isScrollEnabled = false
        mv.isUserInteractionEnabled = false
        mv.isZoomEnabled = false
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    private let addressLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(fixedMapView)
        fixedMapView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        fixedMapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        fixedMapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        fixedMapView.heightAnchor.constraint(equalToConstant: 335) .isActive = true
        
        addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: fixedMapView.bottomAnchor, constant: 15).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        addressLabel.sizeToFit()
    }
    
    private func centerMapOnGymLocation(_ details: SpaceDetails) {
        let radius: Double = 500
        let gymLocation = CLLocationCoordinate2D(latitude: details.latitude, longitude: details.longitude)
        let gymRegionCoordinate = MKCoordinateRegion(center: gymLocation, latitudinalMeters: radius, longitudinalMeters: radius)
        fixedMapView.setRegion(gymRegionCoordinate, animated: true)
        drawMarkerOnMap(gymLocation)
    }
    
    private func drawMarkerOnMap(_ location: CLLocationCoordinate2D) {
//        if #available(iOS 11.0, *) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
        fixedMapView.addAnnotation(annotation)
//        }
    }
    
}
