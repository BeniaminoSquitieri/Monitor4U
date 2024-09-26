//
//  RegisterEmailView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        ZStack {
            Image("Create Account")
                .background()
            VStack {
                DismissView()
                    .padding(.top, 30)
                Spacer()

                Group {
                    Text("Iscriviti per acedere all' app.")
                        .tint(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .padding(.bottom, 2)
                    TextField("Aggiungi la tua email", text: $textFieldEmail)
                    TextField("Aggiungi la tua password", text: $textFieldPassword)
                    Button("Accedi") {
                        authenticationViewModel.createNewUser(email: textFieldEmail,password: textFieldPassword)
                    }
                    .padding(.top, 30)
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
                .padding(.top, 70)
                Spacer()
            }
        }
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthenticationViewModel())
    }
}
