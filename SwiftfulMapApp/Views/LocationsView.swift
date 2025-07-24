//
//  LocationsView.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import SwiftUI
import MapKit

/// The main view in the app to show the header, location preview, and map of the different locations
struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
            
            VStack(spacing: 0) {
                header
                Spacer()
                locationsPreview
            }
        }
        .sheet(item: $viewModel.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
}

extension LocationsView {
    
    /// The top view to show the current location and to select different locations
    private var header: some View {
        
        VStack {
            Button {
                viewModel.toggleLocationsList()
            } label: {
                Text(viewModel.currentLocation.name + ", " + viewModel.currentLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                    }
            }
            .tint(.primary)
            
            
            if viewModel.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()
        .frame(maxWidth: maxWidthForIpad)
    }
    
    /// The bottom view to show a picture of the location, the name, and the city name,
    /// also has two buttons to learn more and go to next location
    private var locationsPreview: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.currentLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(AsymmetricTransition(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                }
            }
        }
    }
    
    /// The map background to show where the locations are and to click to change the current location
    private var mapLayer: some View {
        Map(
            coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(viewModel.currentLocation == location ? 1 : 0.7)
                        .onTapGesture {
                            viewModel.changeCurrentLocation(location: location)
                        }
                }
            }
        )
        .ignoresSafeArea()
    }
    
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
