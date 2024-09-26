//
//  GasGaugeView.swift
//  App
//
//  Created by Beniamino Squitieri on 27/08/22.
//

import SwiftUI

struct FunGaugeView: View {
    @State private var value = 0.5

    @StateObject var mqttManager = MQTTManager.shared()


    var body: some View {
        
        VStack(spacing: 10) {
            Text("Valore attuale:")
                .padding(.leading)

            HStack{
                
                Gauge(value: value){
                    Text("Value")
                        .padding(.top,10)
                }currentValueLabel: {
                    if(mqttManager.isConnected()){
                        if(mqttManager.getTopic()=="Fun"){
                            Text(mqttManager.currentAppState.receivedMessage!)
                        }
                    }
                    else{
                        Text("0")
                    }
                }
                .gaugeStyle(.accessoryCircularCapacity)
                    .tint(.green)
//                if(mqttManager.getTopic()=="Ventola"){
//                    Text(mqttManager.currentAppState.receivedMessage)
//
//                }
                Text("Il sistea di aereazione viene azionato quando l'input è superiore a 50, altrimenti basta avere le finestre aperte per una buona qualità dell'aria")
                    .font(.subheadline)
                    .frame(height: 100)
                    
            }
        }
    }
    func updateValueToStrig()-> String{
        let formattedString = Int(self.value*100)
        return "\(formattedString)" + "%"
    }
//    func updateValueToStrig()-> String{
//        let  formattedString: Int
//        if(mqttManager.getTopic()=="Ventola"){
//            self.value = Double(mqttManager.currentAppState.receivedMessage!)!
//            formattedString = Int(self.value*100)
//            return "\(formattedString)" + "%"
//        }
//        else{
//            formattedString = 0
//        }
//        return "\(formattedString)" + "%"
//
//    }
}

struct FunGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        FunGaugeView()
    }
}
