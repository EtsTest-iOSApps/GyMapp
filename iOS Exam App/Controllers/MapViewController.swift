//
//  MapViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    private var artworks: [MapArtwork] = []
    
    private var spacesList = [SpaceDetails]()
    
    private var spacesImagesArray: [[UIImage]]?
    
    private var spacesDictionary: [String: SpaceDetails]? {
        didSet {
            spacesDictionary?.forEach({ (_, value) in
                spacesList.append(value)
            })
            
            self.displayDataOnMap()
        }
    }
    
    private let initialLocation = CLLocation(latitude: 45.50884, longitude: -73.58781)
    private let regionRadius: CLLocationDistance = 5000
    
    private let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
        setupMap()
        fetchData()
        setupNavigationBar()
        setupViews()
    }
    
    private func setupMap() {
        mapView.delegate = self
        centerMapOnLocation(location: initialLocation)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(handleListPressed))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogoutPressed))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
    }
    
    @objc private func handleListPressed() {
        mesureDistanceBetweenSpaceAndUser()
        
        let layout = UICollectionViewFlowLayout()
        let listVC = ListViewController(collectionViewLayout: layout)
        
        listVC.spacesList = spacesList
        let navController = UINavigationController(rootViewController: listVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    private func mesureDistanceBetweenSpaceAndUser() {
        guard let userLocation = userLocation else { return }
        for index in 0..<spacesList.count {
            let spaceLocation = CLLocation(latitude: spacesList[index].latitude, longitude: spacesList[index].longitude)
            let distance = spaceLocation.distance(from: userLocation) / 1000
            spacesList[index].distanceFromUser = distance
        }
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
                self.spacesDictionary = spaces.spaces
            } catch let err {
                print("Error while parsing json: ", err)
                return
            }
        }.resume()
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func displayDataOnMap() {
        
        spacesList.forEach { (spaceDetail) in
            let spaceCoordinate = CLLocationCoordinate2D(latitude: spaceDetail.latitude, longitude: spaceDetail.longitude)
            let artwork = MapArtwork(coordinate: spaceCoordinate, status: spaceDetail.status, details: spaceDetail)
            artworks.append(artwork)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.artworks)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            showAlert(title: "Disabled", message: "The location services are disabled", action: "OK")
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied:
            showAlert(title: "Denied", message: "The location service is denied for this app", action: "OK")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            showAlert(title: "Restricted", message: "The location service is restricted, you don't have the rights to use it", action: "OK")
        default:
            break
        }
    }
    
    //MARK: - Alert Method
    
    private func showAlert(title: String?, message: String?, action: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: action, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - MapViewDelegate Extension

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MapArtwork else { return }
        let selectedSpaceDetails = annotation.details
        
        let detailVC = DetailViewController()
        detailVC.spaceDetail = selectedSpaceDetails
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - LocationManagerDelegate Extension

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocationCoordinate = manager.location?.coordinate else { return }
        userLocation = CLLocation(latitude: userLocationCoordinate.latitude, longitude: userLocationCoordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
}
