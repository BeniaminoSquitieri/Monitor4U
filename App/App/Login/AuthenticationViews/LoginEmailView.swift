//
//  LoginEmailView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        ZStack {
            Image("LoginAccount")
                .background()
            VStack(spacing: 30) {
                DismissView()
                    .padding(.top, 30)
                Text("👋Benvenuto di nuovo in:\nMonitor4U")
                    .bold()
                .padding(.horizontal,8)
                .padding(.top,150)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .tint(.primary)
                Group {
                    Text("Effettua nuovamente il login per poter accedere all'app")
                        .tint(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                    TextField("Aggiungi la tua email", text: $textFieldEmail)
                    TextField("Aggiungi la tua password", text: $textFieldPassword)
                    Button("Login") {
                        authenticationViewModel.login(email: textFieldEmail,
                                                      password: textFieldPassword)
                    }
                    .padding(.top, 18)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    if let messageError = authenticationViewModel.messageError {
                        Text(messageError)
                            .bold()
                            .font(.body)
                            .foregroundColor(.red)
                            .padding(.top, 20)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 64)
                Spacer()
            }
        }
    }
}

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}
