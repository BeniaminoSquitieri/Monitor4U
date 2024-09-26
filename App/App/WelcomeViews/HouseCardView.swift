//
//  CourseCardView.swift
//  App
//
//  Created by Beniamino Squitieri on 26/08/22.
//

import SwiftUI

struct HouseCardView : View {
    
    var description : Descrizione
    
    var body: some View{
        
        VStack{
            
            VStack(spacing: 30){
                
                Image(description.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top,10)
                    .padding(.leading,10)
                    .frame(maxWidth: 100)
                
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Spacer()
                        
                        Text(description.nome)
                            .font(.title3)
                        
                    }
                    .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(15)
            
            
            
            Spacer(minLength: 0)
            
        }
    }
}


struct HouseCardView_Previews: PreviewProvider {
    static var previews: some View {
        HouseCardView(description: Descrizione(nome: "Nome ", descizione: "Descrizione", image: "coding"))
    }
}
