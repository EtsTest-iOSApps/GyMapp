//
//  MapViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let initialLocation = CLLocation(latitude: 45.50884, longitude: -73.58781)
    private let regionRadius: CLLocationDistance = 5000
    private let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchData()
        setupNavigationBar()
        setupViews()
        centerMapOnLocation(location: initialLocation)
    }
    
    private func setupNavigationBar() {
        
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        if #available(iOS 11.0, *) {
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }
        
    }
    
    private func fetchData() {
        
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
