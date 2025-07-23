//
//  LocationsView.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations) { location in
                        if viewModel.currentLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(radius: 20)
                                .padding()
                                .transition(AsymmetricTransition(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)
                                ))
                        }
                    }
                }
            }
        }
    }
}

extension LocationsView {
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
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
