//
//  LocationDetailView.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import SwiftUI

struct LocationDetailView: View {
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imagesView
                
                VStack() {
                    
                }
            }
        }
        .ignoresSafeArea()
    }
}

extension LocationDetailView {
    
    /// the images for the current location as a slide view
    private var imagesView: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
        .shadow(radius: 20, y: 10)
    }
    
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
}
