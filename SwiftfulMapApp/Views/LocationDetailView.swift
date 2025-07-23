//
//  LocationDetailView.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imagesView
                
                VStack(alignment: .leading, spacing: 16) {
                    titleView
                    Divider()
                    descriptionView
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
    }
}

extension LocationDetailView {
    
    /// The images for the current location as a slide view
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
    
    /// The name and city name of the current location as the title
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("in \(location.cityName)")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    /// The description of the current location
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.title2)
                .fontWeight(.semibold)
            Text(location.description)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link){
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
                    .padding(.top, 8)
            }
        }
    }
    
    /// The map of where the current location is
    private var mapLayer: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: viewModel.mapSpan
        )),
            annotationItems: [location]) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                }
            }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}
