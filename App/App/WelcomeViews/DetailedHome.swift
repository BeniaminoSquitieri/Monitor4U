//
//  DetailedHome.swift
//  App
//
//  Created by Beniamino Squitieri on 26/08/22.
//

import SwiftUI
var descriptions = [

    Descrizione(nome: "Safety",descizione: "Descirizione del sistema di sicurezza dell'abitazione:", image: "coding"),
    Descrizione(nome: "Care",descizione: "Descirizione del sistema di cura dell'abitazione:", image: "ux"),
    Descrizione(nome: "Indice del Gas",descizione: "Informa sul valore del gas:", image: "gas"),
    Descrizione(nome: "Velocità della ventola",descizione: "Informa sulla velocità della ventola del sistema di aerazione:", image: "ventola"),
    Descrizione(nome: "Intruso",descizione: "Informa sulla presenza di intrusi all'interno dell'abitazione, oppure di eventuali anomalie nel livello dell'aria:", image: "allarme")

]
var houses = [
    HouseDescription(nome: "Casa mamma", via: "Via Sodano 38", image: "mamma",house: "CasaMamma"),
    HouseDescription(nome: "Casa papa", via: "Piazza Lago 51", image: "papa",house: "CasaPapa")


]
struct DetailedHome: View{
    @State var txt = ""
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var authenticationViewModel : AuthenticationViewModel
    @EnvironmentObject var mqttManager : MQTTManager
    @EnvironmentObject private var viewModel: LocationViewModel
    @State private var addHouse : Bool = false
    @State private var gridView : Bool = true
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)


    var body: some View {
        VStack{
            
            HStack{
                
                VStack(alignment: .leading, spacing: 10) {

                    Text("Benvenuto \(authenticationViewModel.user?.email ?? "No user")")
                        .font(.title2)
                        .fontWeight(.bold)
                
                }
                .foregroundColor(.black)
                
                Spacer(minLength: 0)
      
                NavigationLink(destination:ProfileView(authenticationViewModel: authenticationViewModel)){
                    Image("profile")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                }
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        Text("Funzionalità:")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                    
                        
                        Button(action: {
                            self.addHouse.toggle()
                        }, label: {
                            Text("Aggiungi casa")
                        })
                    }
                    .foregroundColor(.black)
                    .padding(.top,25)
                        
                    Button{
                        gridView.toggle()
                    } label: {
                        Image(systemName: gridView ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                    if(gridView){
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2),spacing: 20){

                            ForEach(descriptions){description  in

                                NavigationLink(destination: DetailView(description: description, info: description.nome)) {

                                    HouseCardView(description: description)
                                }
                            }
                        }
                        .padding(.top)
                    }
                    else{
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1),spacing: 10){

                            ForEach(descriptions){description  in

                                NavigationLink(destination: DetailView(description: description, info: description.nome)) {

                                    HouseCardView(description: description)
                                }
                            }
                        }
                        .padding(.top)
                    }

                }
                .padding()
                .padding(.bottom,edge!.bottom + 70)
            }
            .sheet(isPresented: $addHouse) {
                MoreHouseView()
            }
        }
    }
}




struct DetailedHome_Previews: PreviewProvider {
    static var previews: some View {
        DetailedHome(authenticationViewModel: AuthenticationViewModel())
    }
}
