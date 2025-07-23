//
//  Location.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    
    var id: String {
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
}
