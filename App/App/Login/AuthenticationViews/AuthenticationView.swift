//
//  ContentView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI
import FacebookLogin
import LegacyCoreKit

enum AuthenticationSheetView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View {
        
        ScrollView{
            ZStack {
                
                Image("Slide Screens")
                    .background()
                    
                VStack(spacing: 0) {
 
                    Text("Collegati con il tuo account")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    VStack(alignment: .center,spacing: 10) {
                        Button {
                            authenticationSheetView = .login
                        } label: {
                            Label("Entra con Email", systemImage: "envelope.fill")
                                .frame(maxWidth: 250)
                                
                        }
                        
                        .tint(.black)
                        Button {
                            authenticationViewModel.loginFacebook()
                        } label: {
                            Label("Entra con Facebook", image: "facebook")
                                .frame(maxWidth: 250)

                        }
                        .tint(.blue)
                        

                        
                    }
                    .controlSize(.large)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.top, 10)
                    
                    HStack() {
                        Button {
                            authenticationSheetView = .register
                        } label: {
                            Text("Non hai un account?")
                                .font(.title3)
                            Image("Next Button")

                        }
                        .tint(.black)
                    }
                    .padding(.bottom,40)
                }
                .sheet(item: $authenticationSheetView) { sheet in
                    switch sheet {
                    case .register:
                        RegisterEmailView(authenticationViewModel: authenticationViewModel)
                    case .login:
                        LoginEmailView(authenticationViewModel: authenticationViewModel)
                    }
                    
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authenticationViewModel: AuthenticationViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
