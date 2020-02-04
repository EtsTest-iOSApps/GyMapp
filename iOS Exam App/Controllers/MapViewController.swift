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
    
    
    private var artworks: [MapArtwork] = []

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
        mapView.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(handleListPressed))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogoutPressed))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
    }
    
    @objc private func handleListPressed() {
        let layout = UICollectionViewFlowLayout()
        let listVC = ListViewController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: listVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func handleLogoutPressed() {
        print("log out!!")
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
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let identifier = "markerId"
            
            if #available(iOS 11.0, *) {
                var annotationView: MapArtworkMarkerView
                if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MapArtworkMarkerView {
                    dequeueView.annotation = annotation
                    annotationView = dequeueView
                } else {
                    annotationView = MapArtworkMarkerView(annotation: annotation, reuseIdentifier: identifier)
                }
                return annotationView
            } else {
                var annotationView: MapArtworkPinView
                if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MapArtworkPinView{
                    dequeueView.annotation = annotation
                    annotationView = dequeueView
                } else {
                    annotationView = MapArtworkPinView(annotation: annotation, reuseIdentifier: identifier)
                }
                return annotationView
            }
        }
}
