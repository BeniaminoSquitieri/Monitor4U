//
//  GasGaugeView.swift
//  App
//
//  Created by Beniamino Squitieri on 27/08/22.
//

import SwiftUI

struct GasGaugeView: View {
    @State private var value = 0.5
    @StateObject var mqttManager = MQTTManager.shared();
    
    var body: some View {
        
        VStack(spacing: 10){
            Text("Valore attuale:")
            Gauge(value: value){
                Text("Value")
            }currentValueLabel: {
                if(mqttManager.isConnected()){
                    if(mqttManager.getTopic()=="Gas"){
                        Text(mqttManager.currentAppState.receivedMessage!)
                    }
                }
                else{
                    Text("0")
                }            }
            .gaugeStyle(.accessoryLinearCapacity)
            .tint(.green)
            
            if(value > 0.7){
                Text("Attenzione valore del gas troppo alto,aria inquinata!!!!!!")
                    .font(.headline)
                    .textCase(.uppercase)
                    .foregroundColor(.red)
            }
            
            
            Slider(value: $value){
                Text("Update value")
            }minimumValueLabel: {
                Text("0")
            }maximumValueLabel: {
                Text("1")
            }
        }

    }
    func updateValueToStrig()-> String{
        let formattedString = Double(self.value)
        return String(format:"%.2f",formattedString)
    }
    private func subscribe(topic: String) {
        mqttManager.subscribe(topic: topic)
    }
}

struct GasGaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GasGaugeView()
    }
}
