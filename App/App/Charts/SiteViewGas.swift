//
//  SiteViewGas.swift
//  App
//
//  Created by Beniamino Squitieri on 05/09/22.
//

import Foundation
struct SiteViewGas: Identifiable{
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = true
}
extension Date{

    func updateHour(value: Int)->Date{
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}
var gasAnalytics: [SiteViewGas] = [
    SiteViewGas(hour: Date().updateHour(value: 0), views: 0.1),
    SiteViewGas(hour: Date().updateHour(value: 1), views: 0.35),
    SiteViewGas(hour: Date().updateHour(value: 2), views: 0.79),
    SiteViewGas(hour: Date().updateHour(value: 3), views: 0.9),
    SiteViewGas(hour: Date().updateHour(value: 4), views: 0.8),
    SiteViewGas(hour: Date().updateHour(value: 5), views: 0.57),
    SiteViewGas(hour: Date().updateHour(value: 6), views: 0.34),
    SiteViewGas(hour: Date().updateHour(value: 7), views: 1),
    SiteViewGas(hour: Date().updateHour(value: 9), views: 0.4),
    SiteViewGas(hour: Date().updateHour(value: 9), views: 0.4),
    SiteViewGas(hour: Date().updateHour(value: 10), views: 0.2),
    SiteViewGas(hour: Date().updateHour(value: 11), views: 0.65),
    SiteViewGas(hour: Date().updateHour(value: 12), views: 0.21),
    SiteViewGas(hour: Date().updateHour(value: 13), views: 0.2),
    SiteViewGas(hour: Date().updateHour(value: 14), views: 0.65),
    SiteViewGas(hour: Date().updateHour(value: 15), views: 0.43),
    SiteViewGas(hour: Date().updateHour(value: 16), views: 0.7),
    SiteViewGas(hour: Date().updateHour(value: 17), views: 0.4),
    SiteViewGas(hour: Date().updateHour(value: 18), views: 0.65),
    SiteViewGas(hour: Date().updateHour(value: 19), views: 0.9),
    SiteViewGas(hour: Date().updateHour(value: 20), views: 0.4),
    SiteViewGas(hour: Date().updateHour(value: 21), views: 0.2),
    SiteViewGas(hour: Date().updateHour(value: 22), views: 0.5),
    SiteViewGas(hour: Date().updateHour(value: 23), views: 0.98),

]

