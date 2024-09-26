//  HomeView.swift
//
//  Created by Beniamino Squitieri on 17/08/22.
//

import SwiftUI

struct HomeView: View {
    let text : String
    let house :Image
    
    var body: some View {
        NavigationView{
                VStack(alignment: .center, spacing: 35){
                
                    house
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400,height: 100)
                    Home()

                }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(text: "Casa Mamma", house: Image("CasaMamma"))
            .previewInterfaceOrientation(.portrait)
    }
}
