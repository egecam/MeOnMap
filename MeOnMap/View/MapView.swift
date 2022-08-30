//
//  ContentView.swift
//  MeOnMap
//
//  Created by Ege Çam on 30.08.2022.
//

import CoreLocationUI
import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .ignoresSafeArea()
                    .accentColor(.green)
                
                LocationButton(.currentLocation) {
                    viewModel.requestAllowOnceLocationPermission()
                }
                .foregroundColor(.white)
                .cornerRadius(8)
                .symbolVariant(.fill)
                .tint(.green)
                .padding(.bottom, 50)
                .animation(.easeIn(duration: 3), value: 2)
            }
        }
        .navigationTitle("Location")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
