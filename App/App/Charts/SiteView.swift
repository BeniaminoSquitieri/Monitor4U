//
//  SiteViewGas.swift
//  App
//
//  Created by Beniamino Squitieri on 23/08/22.
//

import SwiftUI


struct SiteView: Identifiable{
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
}

var sample_analytics: [SiteView] = [
    SiteView(hour: Date().updateHour(value: 8), views: 1500),
    SiteView(hour: Date().updateHour(value: 9), views: 2625),
    SiteView(hour: Date().updateHour(value: 10), views: 7500),
    SiteView(hour: Date().updateHour(value: 11), views: 3688),
    SiteView(hour: Date().updateHour(value: 12), views: 2988),
    SiteView(hour: Date().updateHour(value: 13), views: 3289),
    SiteView(hour: Date().updateHour(value: 14), views: 4500),
    SiteView(hour: Date().updateHour(value: 15), views: 6788),
    SiteView(hour: Date().updateHour(value: 16), views: 9988),
    SiteView(hour: Date().updateHour(value: 17), views: 7866),
    SiteView(hour: Date().updateHour(value: 18), views: 1989),
    SiteView(hour: Date().updateHour(value: 19), views: 6456),
    SiteView(hour: Date().updateHour(value: 20), views: 3467),
]
