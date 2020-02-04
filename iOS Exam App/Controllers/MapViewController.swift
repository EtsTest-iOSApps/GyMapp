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
    
    
    var artworks: [MapArtwork] = []
    
    
    

    private var spacesList = [String: SpaceDetails]()
    private let initialLocation = CLLocation(latitude: 45.50884, longitude: -73.58781)
    private let regionRadius: CLLocationDistance = 5000
    private let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        fetchData()
        setupNavigationBar()
        setupViews()
        centerMapOnLocation(location: initialLocation)
    }
    
    private func setupMap() {
        mapView.register(MapArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
    }
    
    private func setupNavigationBar() {
        
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        if #available(iOS 11.0, *) {
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        } else {
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }
        
    }
    
    private func fetchData() {
        
        let stringURL = "https://bitbucket.org/!api/2.0/snippets/silofit/MKGnq5/b604989379e251488e962337bf405aed2cdfdc34/files/iOS-Exam-Database.json"
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error while trying to get data: ", error)
                return
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let spaces = try decoder.decode(Spaces.self, from: data)
                self.spacesList = spaces.spaces
            } catch let err {
                print("Error while parsing json: ", err)
                return
            }
            self.displayDataOnMap()
        }.resume()
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func displayDataOnMap() {
        
        spacesList.forEach { (key: String, spaceDetail: SpaceDetails) in
            let spaceCoordinate = CLLocationCoordinate2D(latitude: spaceDetail.latitude, longitude: spaceDetail.longitude)
            let artwork = MapArtwork(coordinate: spaceCoordinate, status: spaceDetail.status)
            artworks.append(artwork)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.artworks)
        }
        
    }
}

extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        let identifier = "markerId"
//        var annotationView: MKMarkerAnnotationView
//        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
//            dequeueView.annotation = annotation
//            annotationView = dequeueView
//        } else {
//            if #available(iOS 11.0, *) {
//                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            } else {
////                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView = MKMarkerAnnotationView(frame: .init())
//            }
//        }
////        annotationView.markerTintColor = .green
//        return annotationView
//    }
    
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let identifier = "markerId"
            var annotationView: MapArtworkView
            if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MapArtworkView {
                dequeueView.annotation = annotation
                annotationView = dequeueView
            } else {
                if #available(iOS 11.0, *) {
                    annotationView = MapArtworkView(annotation: annotation, reuseIdentifier: identifier)
                } else {
    //                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView = MapArtworkView(frame: .init())
                }
            }
    //        annotationView.markerTintColor = .green
            return annotationView
        }
}
