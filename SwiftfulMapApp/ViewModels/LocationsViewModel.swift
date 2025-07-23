//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
