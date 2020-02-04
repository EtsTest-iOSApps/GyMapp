//
//  MapArtwork.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import Foundation
import MapKit

class MapArtwork: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let status: String
    
//    init(name: String?, coordinate: CLLocationCoordinate2D, status: String) {
    init(coordinate: CLLocationCoordinate2D, status: String) {
        self.coordinate = coordinate
        self.status = status
        super.init()
    }
    
    var pinTintColor: UIColor {
        switch status {
        case "opened":
            return .green
        case "coming_soon":
            return .red
        default:
            return .yellow
        }
    }
    
//    var title: String? {
//        return status
//    }
//
//    var subtitle: String?
}
