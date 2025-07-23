//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @StateObject private var viewModel = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
