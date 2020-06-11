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
    let details: SpaceDetails?

    init(coordinate: CLLocationCoordinate2D, status: String, details: SpaceDetails?) {
        self.coordinate = coordinate
        self.status = status
        self.details = details
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
}
