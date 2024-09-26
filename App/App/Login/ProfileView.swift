//
//  ProfileView.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var expandVerificationWithEmailForm: Bool = false
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""

    var body: some View {
        NavigationView {

            Form {
                Section {
                    Button(action: {
                        expandVerificationWithEmailForm.toggle()
                        print("Collega e-mail e password")
                    }, label: {
                        Label("Collega Email", systemImage: "envelope.fill")
                    })
                        .disabled(authenticationViewModel.isEmailAndPasswordLinked())
                    if expandVerificationWithEmailForm {
                        Group {
                            Text("Collega la tua email con la sessione a cui hai effettuato l'accesso.")
                                .tint(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                            TextField("Aggiungi la tua email", text: $textFieldEmail)
                            TextField("Aggiungi la tua password", text: $textFieldPassword)
                            Button("Accetta") {
                                authenticationViewModel.linkEmailAndPassword(email: textFieldEmail,password: textFieldPassword)
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
                    }
                    Button(action: {
                        authenticationViewModel.linkFacebook()
                    }, label: {
                        Label("Collegati con Facebook", image: "facebook")
                    })
                        .disabled(authenticationViewModel.isFacebookLinked())
                } header : {
                    Text("Collega altri account alla sessione corrente")
                }

            }
            .task {
                authenticationViewModel.getCurrentProvider()
            }
            .alert(authenticationViewModel.isAccountLinked ? "Account collegato!" : "Errore",
                   isPresented: $authenticationViewModel.showAlert) {
                Button("Accetta") {
                    print("Ignora avviso")
                    if authenticationViewModel.isAccountLinked {
                        expandVerificationWithEmailForm = false
                    }
                }
            } message: {
                Text(authenticationViewModel.isAccountLinked ? "✅ Hai appena collegato il tuo account" : "❌ Impossibile collegare l'account")
            }
            .navigationBarTitle("Profile")}
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authenticationViewModel: AuthenticationViewModel())
    }
}
