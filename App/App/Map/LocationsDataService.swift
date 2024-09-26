//
//  LocationsDataService.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 16/08/22.
//

import Foundation
import MapKit
import SwiftUI

class LocationsDataService {
    
    static let locations: [Location] = [
        
        Location(name: "La mia posizione", coordinate: CLLocationCoordinate2D(latitude: 40.77283, longitude: 14.79307), image: Image(systemName: "figure.wave.circle"), imageCard: Image(systemName: "figure.wave.circle")),
        Location(name: "Casa Mamma", coordinate: CLLocationCoordinate2D(latitude: 40.816599, longitude: 14.613018), image: Image("mamma"), imageCard: Image("CasaMamma")),
        Location(name: "Casa Papa", coordinate:  CLLocationCoordinate2D(latitude: 40.808181, longitude:  14.617398), image: Image("papa"), imageCard: Image("CasaPapa"))]

}
