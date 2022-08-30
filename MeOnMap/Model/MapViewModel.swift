//
//  MapViewModel.swift
//  MeOnMap
//
//  Created by Ege Çam on 30.08.2022.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 41.015137, longitude: 28.979530)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan )
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            // error handling
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

