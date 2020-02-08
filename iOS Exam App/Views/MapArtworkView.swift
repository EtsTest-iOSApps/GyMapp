//
//  MapArtworkView.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-04.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import Foundation
import MapKit

@available(iOS 11.0, *)
class MapArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? MapArtwork else { return}
            markerTintColor = artwork.pinTintColor
            
        }
    }
}

class MapArtworkPinView: MKPinAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? MapArtwork else { return}
            pinTintColor = artwork.pinTintColor
        }
    }
}
