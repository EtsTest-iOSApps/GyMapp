//
//  SpacesModel.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

struct Spaces: Decodable {
    let spaces: [String: SpaceDetails]
    
    private enum CodingKeys: String, CodingKey {
        case spaces = "spaces"
    }
}

struct SpaceDetails: Decodable {
    let address: String
    let amenities: [String]
    let city: String
    let description: String
    let equipments: [String]
    let floor: String
    var imageUrls: [String]
    let latitude: Double
    let longitude: Double
    let maxCapacity: Int
    let name: String
    let openDays: String
    let openHours: String
    let rate: Int
    let slug: String
    let spaceId: String
    let squareFootage: Int
    let status: String
    let timeZone: String
    
    private enum CodingKeys: String, CodingKey {
        case address = "address"
        case amenities = "amenities"
        case city = "city"
        case description = "description"
        case equipments = "equipments"
        case floor = "floor"
        case imageUrls = "image_urls"
        case latitude = "latitude"
        case longitude = "longitude"
        case maxCapacity = "max_capacity"
        case name = "name"
        case openDays = "open_days"
        case openHours = "open_hours"
        case rate = "rate"
        case slug = "slug"
        case spaceId = "space_id"
        case squareFootage = "square_footage"
        case status = "status"
        case timeZone = "timezone"
    }
    
    var distanceFromUser: Double?
}
