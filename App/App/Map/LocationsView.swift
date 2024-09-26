//
//  LocationsView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 16/08/22.
//

import SwiftUI
import MapKit



struct LocationsView: View {

    @EnvironmentObject private var viewModel: LocationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                mapLayer
                VStack {
                    header
                        .padding()
                    Spacer()
                    locationsPreviewStack
                    
                }
                .padding(.top, 50.0)
                
            }
            
            .navigationBarHidden(true)
            
        }.environmentObject(viewModel)
            
        .padding(.top, -47.0)
        .ignoresSafeArea()
        .accentColor(Color(.systemBlue))
        .onAppear(){
            viewModel.checkIfLocationServicesIsEnabled()
        }
        
    }
        
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Button(action: viewModel.toggleLocationList) {
                Text(viewModel.mapLocation.name)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.cyan)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                    }
            }
            
            if viewModel.showLocationsList {
                LocationsListView()
            }
            
        }
        .background(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinate) {
                if location.name != "La mia posizione" {
    
                    NavigationLink{
                        HomeView(text: location.name, house: location.imageCard)

                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 44, height: 40)
                    }
                    
                    LocationMapAnnotationView()
                        .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showNextLocation(location: location)
                    }
                }else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50)
                        .scaledToFill()
                    
                }
                
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 15)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}






struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationViewModel())
    }
}
