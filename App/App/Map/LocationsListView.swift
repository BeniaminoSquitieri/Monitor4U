//
//  LocationsListView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 16/08/22.
//

import SwiftUI
import MapKit

struct LocationsListView: View {
    
    @EnvironmentObject private var viewModel: LocationViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button {
                    viewModel.showNextLocation(location: location)
                } label: {
                   listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
        .environmentObject(viewModel)
    }
}

extension LocationsListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            location.image
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .cornerRadius(10)
                .foregroundColor(.black)
            
            VStack(alignment: .leading) {
                Text(location.name)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black)
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView().environmentObject(LocationViewModel())
    }
}
