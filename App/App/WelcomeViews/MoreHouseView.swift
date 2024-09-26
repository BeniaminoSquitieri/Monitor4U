//
//  MoreHouseView.swift
//  App
//
//  Created by Beniamino Squitieri on 01/09/22.
//

import SwiftUI
import CoreLocation
import PhotosUI

struct MoreHouseView: View {
    @State var houseName: String = ""
    @State var latitude: String = ""
    @State var longitude : String = ""
    @State var road : String = ""
    @State var disableLatitude : Bool = false
    @State var disableLongitude : Bool = false
    @State var disableName : Bool = false
    @State var disableRoad : Bool = false
    @State var selectedItems : [PhotosPickerItem] = []
    @State var data: Data?
    @State var existingHouse : Bool = false
    

    @EnvironmentObject private var viewModel: LocationViewModel

    var body: some View {
        VStack(alignment:.leading,spacing: 10) {

            Form {
                Section {
                    TextField("Nome Casa", text: $houseName)
                    TextField("Latitudine", text: $latitude)
                    TextField("Longitudine", text: $longitude)
                    TextField("Via", text: $road)
                    Button {
                        if(houses.contains(HouseDescription(nome: houseName, via: road, image:"person.fill")) || viewModel.locations.contains(Location(name: houseName, coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude:  Double(longitude)!), image: Image(systemName: "person.circle.fill"), imageCard: Image(systemName: "house.fill")))){
                            existingHouse.toggle()
                        }
                        else{
                            houses.append(HouseDescription(nome: houseName, via: road, image:"person.fill"))
                            viewModel.locations.append(Location(name: houseName, coordinate: CLLocationCoordinate2D(latitude: Double(latitude)!, longitude:  Double(longitude)!), image: Image(systemName: "person.circle.fill"), imageCard: Image(systemName: "house.fill")))
                        }
                        
                        
                    } label: {
                        Text("Aggiungi")
                        
                    }
                    .disabled(disableButton())
                    .padding(.leading,100)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .alert(isPresented: $existingHouse) {
                        Alert(title: Text("Casa gia presente"))
                    }
                    
                } header : {
                    Text("Casa da aggiungere")
                }
            }

        }
        
    }

    func disableButton()-> Bool {
        if(houseName==""){
            disableName.toggle()
        }
        if(latitude==""){
            disableLatitude.toggle()
        }
        if(longitude==""){
            disableLongitude.toggle()
        }
        if(road==""){
            disableRoad.toggle()
        }
        return disableRoad && disableName && disableLatitude && disableLongitude
    }
}

struct MoreHouseView_Previews: PreviewProvider {
    static var previews: some View {
        MoreHouseView()
    }
}
