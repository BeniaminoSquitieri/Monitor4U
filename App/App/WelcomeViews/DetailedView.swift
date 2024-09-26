//
//  DetailedView.swift
//  App
//
//  Created by Beniamino Squitieri on 26/08/22.
//

import SwiftUI

struct DetailView : View {
    
    var description : Descrizione
    var info : String
    @StateObject var mqttManager = MQTTManager.shared()


    var body: some View{
        
        VStack(alignment: .leading ,spacing: 10) {
            Spacer(minLength: 10)
            Text(description.nome)
                .font(.title)
                .fontWeight(.bold)
            Spacer(minLength: 10)
            Text(description.descizione)
                .font(.title3)
                .fontWeight(.medium)
                
            Section{
                if(info=="Velocità della ventola"){
                    Text("Il sistema di aerazione contribuisce al corretto funzionamento del sistema di care, contribuendo all'eliminazione del gas in eccesso. Il sistema si azione nel momento in cui la presenza del gas raggiunge livelli critici riducendoli tramite l'apposita ventola")
                        .font(.subheadline)
                }
                if(info=="Indice del Gas"){
                    Text("Il valore del gas aumenta quando nell'abitazione sono presenti sostanze tossiche oppure infiammabili e tende ad azionare il sistema di aereazione per ristabilire i valori normali di un ambiente domestico.")
                        .font(.headline)
                }
                if(info=="Care"){
                    Text("Il sistema di aerazione contribuisce al corretto funzionamento del sistema di care, contribuendo all'eliminazione del gas in eccesso. Il sistema si azione nel momento in cui la presenza del gas raggiunge livelli critici riducendoli tramite l'apposita ventola")
                        .font(.subheadline)
                }
                if(info=="Safety"){
                    Text("Il sistema di aerazione contribuisce al corretto funzionamento del sistema di care, contribuendo all'eliminazione del gas in eccesso. Il sistema si azione nel momento in cui la presenza del gas raggiunge livelli critici riducendoli tramite l'apposita ventola")
                        .font(.subheadline)
                }
            }
            ScrollView{
                VStack(alignment: .leading ,spacing: 10) {
                    Text("Lista delle tue abitazioni:")
                        .font(.title3)
                    List(houses) { house in
                        HStack{
                            if(mqttManager.isConnected() && mqttManager.currentAppState.receivedMessage=="Intruso"){
                                VStack{
                                    Text(house.nome)
                                        .font(.title)
                                        .foregroundColor(.red)
                                    Text(house.via)
                                        .font(.title3)
                                        .foregroundColor(.red)
                                    Text("Intruso nella tua abitazione")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                }
                                
                            }
                            else{
                                VStack{
                                    Text(house.nome)
                                        .font(.title)
                                    Text(house.via)
                                        .font(.title3)
                                }
                            }
                            Spacer()
                            Image(house.image)
                                .resizable()
                                .frame(maxWidth: 50,maxHeight: 50)
                        }
                        
                    }
                    .frame(height: 500)
                }
            }

        }
        .navigationTitle(description.nome)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {}, label: {
            
            

        }))
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(description: Descrizione(nome: "Nome ", descizione: "Descrizione", image: "coding"), info: "Safety")
    }
}
