//
//  LocationMapAnnotationView.swift
//  SwiftfulMapApp
//
//  Created by Tirzaan on 7/23/25.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(.accent)
                .clipShape(.circle)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.accent)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .padding(.top, -3)
                .padding(.bottom, 40)
        }
        .shadow(radius: 10)
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        
        LocationMapAnnotationView()
    }
}
