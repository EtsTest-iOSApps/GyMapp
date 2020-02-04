//
//  MapArtworkView.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import Foundation
import MapKit

//class MapArtworkView: MKAnnotationView {
//    override var annotation: MKAnnotation? {
//        willSet {
//            guard let artwork = newValue as? MapArtwork else { return}
//            tintColor = artwork.pinTintColor
//        }
//    }
//}

class MapArtworkView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? MapArtwork else { return}
            markerTintColor = artwork.pinTintColor
        }
    }
}
