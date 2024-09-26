//
//  HomeView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI

struct homeView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    
    var body: some View {
        NavigationView {
            ZStack{
                TabView {
                    VStack {
                        Spacer()
                        DetailedHome(authenticationViewModel: authenticationViewModel)

                    }
                    
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                   ProfileView(authenticationViewModel: authenticationViewModel)
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                    LocationsView()
                        .tabItem{
                        Label("Map",systemImage: "globe.americas.fill")
                            
                        }
                }
                .ignoresSafeArea(.all,edges: .bottom)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Logout") {
                        authenticationViewModel.logout()
                    }.foregroundColor(.red)
                }
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView(authenticationViewModel: AuthenticationViewModel())
    }
}
