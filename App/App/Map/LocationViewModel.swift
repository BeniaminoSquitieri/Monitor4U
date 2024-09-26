//
//  LocationsViewModel.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 16/08/22.
//

import Foundation
import MapKit
import SwiftUI

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locations: [Location]

    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.812993, longitude: 14.618299), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    @Published var showLocationsList: Bool = false
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }

    var locationManager: CLLocationManager?
    
    override init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
    }

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Mostra un avviso per informarti che è disattivato e lo attiva.")
        }
    }

    func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }

        switch locationManager.authorizationStatus {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("La tua posizione è probabilmente limitata a causa del controllo genitori.")
        case .denied:
            print("Hai negato l'autorizzazione alla posizione di questa app. Vai nelle impostazioni per cambiarlo.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            if location.name == "" {
                mapLocation = Location(name: "La mia posizione", coordinate: CLLocationCoordinate2D(latitude: locationManager?.location!.coordinate.latitude ?? 37.331516, longitude: locationManager?.location!.coordinate.longitude ?? -121.891054),imageCard: Image(systemName: "house.fill"))
            } else {
                mapLocation = location
            }
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {

        
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation}) else {
            print("Non è possibile trovare la posizione nell'array locations. Non dovrebbe mai accadere")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {

            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}


