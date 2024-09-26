//
//  HomeLocation.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 16/08/22.
//

import Foundation
import MapKit
import SwiftUI

struct Location: Identifiable, Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name
    }

    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    var image = Image(systemName: "person")
    var imageCard: Image
}
