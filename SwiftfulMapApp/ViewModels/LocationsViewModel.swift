//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    @Published var currentLocation: Location {
        didSet {
            updateMapRegion(location: currentLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        if let firstLocation = locations.first {
            self.currentLocation = firstLocation
        } else {
            self.currentLocation = Location(
                name: "No Location Found",
                cityName: "None",
                coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                description: "No description",
                imageNames: [],
                link: "")
        }
        self.updateMapRegion(location: currentLocation)
    }
    
    private func updateMapRegion (location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        }
    }
}
