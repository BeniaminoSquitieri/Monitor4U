//
//  Descrizione.swift
//  App
//
//  Created by Beniamino Squitieri on 26/08/22.
//

import Foundation
import UIKit

struct HouseDescription : Identifiable,Equatable{
    var id = UUID().uuidString
    var nome: String
    var via : String
    var image : String
    var house : String?
    var UIhouse : UIImage?
}
