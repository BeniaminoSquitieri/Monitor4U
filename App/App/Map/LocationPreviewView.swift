//
//  LocationPreviewView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 16/08/22.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var viewModel: LocationViewModel
    
    let location: Location
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                if location.name != "La mia posizione" {
                    apriInMappeButton
                }
                nextButton
                
            }
            
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
            
        }
        .cornerRadius(10)
    } 
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            location.imageCard
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .foregroundColor(Color.black)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            if location.name == "My Location" {
                Text("You are here")
            } 
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color.cyan)
        
    }
    
    
    private var apriInMappeButton: some View {
        Button {
            let url = URL(string: "maps://?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)")
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        } label: {
            Text("Apri in Maps")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            viewModel.nextButtonPressed()
        } label: {
            Text("Prossimo")
                .font(.headline)
                .frame(width: 125, height: 35)
            
        }
        .foregroundColor(Color.cyan)
        .buttonStyle(.bordered)

        
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding()
        }.environmentObject(LocationViewModel())
    }
    
    
}
