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
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show List of locations
    @Published var showLocationsList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
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
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func changeCurrentLocation(location: Location) {
        withAnimation(.easeInOut) {
            currentLocation = location
            showLocationsList = false
        }
    }
    
    func changeToNextLocation() {
        // Get the Current Index
        guard let currentIndex = locations.firstIndex (where: { $0 == currentLocation }) else { return }
        
        // Check if the nextIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            guard let firstLocation = locations.first else { return }
            changeCurrentLocation(location: firstLocation)
            return
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        changeCurrentLocation(location: nextLocation)
    }
}
