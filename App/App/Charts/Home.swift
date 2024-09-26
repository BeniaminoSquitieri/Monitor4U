//
//  Home.swift
//  SwiftCharts
//
//  Created by Beniamino Squitieri on 23/08/22.
//

import SwiftUI
import Charts


class Gas : ObservableObject {
    @Published var items = String()

}

struct Home: View {

    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var gasIndex: Gas
    @State var message: String = ""

    @State var sampleAnalytics: [SiteView] = sample_analytics

    @State var currentTab: String = "7 Days"
    @State var currentActiveItem: SiteView?
    @State var currentActiveGasItem: SiteViewGas?

    @State var plotWidth: CGFloat = 0

    @State var isLineGraph: Bool = false
    @State var careSystem: Bool = false
    @State var safetySystem: Bool = false
    @State var resetGraph: Bool = false

    @State private var value = 0.5
    @State private var mqttView : Bool = false
    @State var vediGas: Bool = false
    @State var vediCare: Bool = false
    @State var mandaCare: Bool = false
    @State var vediVentola: Bool = false
    @State var vediSafety: Bool = false
    @State var vediIntruso: Bool = false
    @State var grid: Bool = true
    var topicVector: [Topic] = [Topic(topic: "Gas"),Topic(topic: "Care"),Topic(topic: "Ventola"),Topic(topic: "Safety"),Topic(topic: "Intruso")]

    @StateObject var mqttManager = MQTTManager.shared()

    

    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        NavigationView{
                ScrollView{
                    ConnectionStatusBar(message: mqttManager.connectionStateMessage(), isConnected: mqttManager.isConnected())
                    if(mqttManager.isConnected()){


                        VStack{

                            VStack(alignment: .leading, spacing: 12){

                                HStack{
                                    
                                    Text("Seleziona dispositivi")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                    Button {
                                        grid.toggle()
                                        
                                    } label: {
                                    
                                        Image(systemName: grid ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                                            .font(.system(size: 24))
                                            .foregroundColor(.black)
                                    }

                                }
                                .padding(.horizontal)
                                .padding(.top,25)
                                
                                if(grid){
                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2),spacing: 20){
                                        ForEach(topicVector) { topic in
                                            VStack{
                                                if(topic.topic=="Care"){
                                                    Image("ux")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Care", isOn: $vediCare)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Safety"){
                                                    Image("coding")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Safety", isOn: $vediSafety)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Intruso"){
                                                    Image("allarme")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Intruso", isOn: $vediIntruso)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Ventola"){
                                                    Image("ventola")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Ventola", isOn: $vediVentola)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Gas"){
                                                    Image("gas")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Gas", isOn: $vediGas)
                                                        .padding(.top)
                                                }
                                         
                                            }
                                        }
                                        
                                    }
                                    .padding(.top)
                                    
                                }
                                else{
                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1),spacing: 20){
                                        ForEach(topicVector) { topic in
                                            VStack{
                                                if(topic.topic=="Care"){
                                                    Image("ux")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Care", isOn: $vediCare)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Safety"){
                                                    Image("coding")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Safety", isOn: $vediSafety)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Intruso"){
                                                    Image("allarme")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Intruso", isOn: $vediIntruso)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Ventola"){
                                                    Image("ventola")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Ventola", isOn: $vediVentola)
                                                        .padding(.top)
                                                }
                                                if(topic.topic=="Gas"){
                                                    Image("gas")
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    Toggle("Vedi Gas", isOn: $vediGas)
                                                        .padding(.top)
                                                }
                                            }
                                        }

                                    }
                                    .padding(.top)
                                }

                                
                                
                                
                            }
                            .padding()

                            if(vediGas){
                                Section("Grafico del gas"){
                                    HStack{
                                        Text("Premere il bottone per vedere valori live")
                                        Button(action: functionForGas(state: mqttManager.currentAppState.appConnectionState)) {
                                            Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                                                .font(.system(size: 14.0))
                                        }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                                            .frame(width: 100)
                                            .disabled(!mqttManager.isConnected())
                                    }
                                    
                                    Text("Indice dei valori di gas")
                                    
                                    AnimatedGasChart()
                                    Toggle("Grafico a linea", isOn: $isLineGraph)
                                        .padding(.top)
                                    Toggle("Azzera grafico", isOn: $resetGraph)
                                        .padding(.top)
                                    Section(){
                                        Text("Valore Gas")
                                            .font(.title3)
                                        VStack(alignment: .leading){
                                            Text("GAS:")
                                                .font(.title3)
                                            GasGaugeView()
                                            
                                        }

                                    }
                                }
                            }
                            if(vediCare){
                                HStack{
                                    Text("Premere il bottone per vedere valori live")
                                    Button(action: functionForCare(state: mqttManager.currentAppState.appConnectionState)) {
                                        Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                                            .font(.system(size: 14.0))
                                    }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                                        .frame(width: 100)
                                        .disabled(!mqttManager.isConnected())
                                }
                                if(mqttManager.getTopic()=="Care"){
                                    if(careSystem){
                                        Text("CareSystem attivato")
                                        Button(action: send(message: "disattivaCare")) {
                                            Toggle(isOn: $careSystem) {
                                                Text("Premi per disattivare Care")
                                            }
                                        }
                                    }
                                    else{
                                        Text("CareSystem disattivato")
                                        Button(action: send(message: "attivaCare")) {
                                            Toggle(isOn: $careSystem) {
                                                Text("Premi per attivare Care")
                                            }
                                        }
                                    }
                                }
                            }
                            if(vediSafety){
                                HStack{
                                    Text("Premere il bottone per vedere valori live")
                                    Button(action: functionForSafety(state: mqttManager.currentAppState.appConnectionState)) {
                                        Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                                            .font(.system(size: 14.0))
                                    }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                                        .frame(width: 100)
                                        .disabled(!mqttManager.isConnected())
                                }
                                if(mqttManager.getTopic()=="Safety"){
                                    if(safetySystem){
                                        Text("SafetySystem attivare")
                                        Button(action: send(message: "disattivaSafety")) {
                                            Toggle(isOn: $safetySystem) {
                                                Text("Premi per disattivare Safety")
                                            }
                                        }
                                    }
                                    else{
                                        Text("SafetySystem disattivato")
                                        Button(action: send(message: "attivaSafety")) {
                                            Toggle(isOn: $safetySystem) {
                                                Text("Premi per attivare Safety")
                                            }
                                        }
                                    }
                                }
                            }
                            if(vediVentola){
                                HStack{
                                    Text("Premere il bottone per vedere valori live")
                                    Button(action: functionForFun(state: mqttManager.currentAppState.appConnectionState)) {
                                        Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                                            .font(.system(size: 14.0))
                                    }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                                        .frame(width: 100)
                                        .disabled(!mqttManager.isConnected())
                                }
                                Section(){
                                    
                                    Text("Valori sistema di Aerazione")
                                        .font(.title3)
                                    VStack(alignment: .leading){
                                        Text("Ventola:")
                                            .font(.title3)
                                        FunGaugeView()

                                    }

                                }
                            }
                            if(vediIntruso){
                                HStack{
                                    Text("Premere il bottone per vedere valori live")
                                    Button(action: functionForIntruder(state: mqttManager.currentAppState.appConnectionState)) {
                                        Text(titleForSubscribButtonFrom(state: mqttManager.currentAppState.appConnectionState))
                                            .font(.system(size: 14.0))
                                    }.buttonStyle(BaseButtonStyle(foreground: .white, background: .green))
                                        .frame(width: 100)
                                        .disabled(!mqttManager.isConnected())
                                }
                                if(mqttManager.getTopic()=="Intruso" && mqttManager.currentAppState.receivedMessage=="Intruso"){
                                    Text("WARNING INTRUSO NELLA TUA ABITAZIONE")
                                        .font(.largeTitle)
                                        .foregroundColor(.red)
                                    
                                }
                                else{
                                    Text("Nessun intruso all'interno della tua abitazione")
                                }
                            }
                            

                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding()
                        .onChange(of: currentTab) { newValue in
                            sampleAnalytics = sample_analytics
                            if newValue != "7 Days"{
                                for (index,_) in sampleAnalytics.enumerated(){
                                    sampleAnalytics[index].views = .random(in: 1500...10000)
                                }
                            }

                            animateGraph(fromChange: true)
                            
                        }
                    }
                    else{
                        Image("Connessione")
                            .background()
                    }
                }
            .navigationBarItems(leading: Button(action: {
                mqttManager.initializeMQTT(host : "Test.mosquitto.org", identifier: UUID().uuidString)
                mqttManager.connect()
            }, label: {
                Text("Connettiti alla casa")
            }))
        }

                                       
    }
                                      
    @ViewBuilder
    func AnimatedGasChart()->some View{
        let maxGas = gasAnalytics.max { item1, item2 in
            return item2.views > item1.views
        }?.views ?? 0

        if resetGraph {
            Chart{
                ForEach(gasAnalytics){item in
                    LineMark(
                        x: .value("Hour", item.hour,unit: .hour),
                        y: .value("Views",0)
                    )
                    .foregroundStyle(Color("Blue").gradient)
                    .interpolationMethod(.catmullRom)
                }
            }
        }
        else{
            Chart{
                
                ForEach(gasAnalytics){itemGas in

                    if isLineGraph{
                        LineMark(
                            x: .value("Hour", itemGas.hour,unit: .hour),
                            y: .value("Views", itemGas.animate ? itemGas.views : 0)
                        )
                        .foregroundStyle(Color("Blue").gradient)
                        .interpolationMethod(.catmullRom)
                    }else{
                        BarMark(
                            x: .value("Hour", itemGas.hour,unit: .hour),
                            y: .value("Views", itemGas.animate ? itemGas.views : 0)
                        )
                        .foregroundStyle(Color("Blue").gradient)
                    }

                    if isLineGraph{
                        AreaMark(
                            x: .value("Hour", itemGas.hour,unit: .hour),
                            y: .value("Views", itemGas.animate ? itemGas.views : 0)
                        )
                        .foregroundStyle(Color("Blue").opacity(0.1).gradient)
                        .interpolationMethod(.catmullRom)
                    }

                    if let currentActiveItem,currentActiveItem.id == itemGas.id{
                        RuleMark(x: .value("Hour", currentActiveItem.hour))
                            .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                            .offset(x: (plotWidth / CGFloat(gasAnalytics.count)) / 2)
                            .annotation(position: .top){
                                VStack(alignment: .leading, spacing: 6){
                                    Text("Valore")
                                        .font(.caption)
                                        .foregroundColor(.gray)

                                    Text(currentActiveItem.views.stringFormat)
                                        .font(.title3.bold())
                                }
                                .padding(.horizontal,10)
                                .padding(.vertical,4)
                                .background {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
                                }
                            }
                    }
                }
            }
            .chartYScale(domain: 0...1)
            .chartOverlay(content: { proxy in
                GeometryReader{innerProxy in
                    Rectangle()
                        .fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged{value in
                                    let location = value.location
                              
                                    if let date: Date = proxy.value(atX: location.x){
                                        // estraggo l'ora
                                        let calendar = Calendar.current
                                        let hour = calendar.component(.hour, from: date)
                                        if let currentItem = sampleAnalytics.first(where: { item in
                                            calendar.component(.hour, from: item.hour) == hour
                                        }){
                                            self.currentActiveItem = currentItem
                                            self.plotWidth = proxy.plotAreaSize.width
                                        }
                                    }
                                }.onEnded{value in
                                    self.currentActiveItem = nil
                                }
                        )
                }
            })
            .frame(height: 150)
            .onAppear {
                animateGraph()
            }
        }





    }

    func animateGraph(fromChange: Bool = false){
        for (index,_) in sampleAnalytics.enumerated(){

            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.10)){
                withAnimation(fromChange ? .easeInOut(duration: 0.6) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)){
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
    func setTopic(top: String){
        mqttManager.setTopic(top: top)
    }
    private func subscribe(topic: String) {
        mqttManager.subscribe(topic: topic)
    }

    private func usubscribe() {
        mqttManager.unSubscribeFromCurrentTopic()
    }

    private func send(message: String) -> () -> Void{
        
        let finalMessage = "Monitor4U dice: \(message)"
        mqttManager.publish(with: finalMessage)
        self.message = ""
        return {mqttManager.publish(with: finalMessage)}
        
    }
    private func titleForSubscribButtonFrom(state: MQTTAppConnectionState) -> String {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return "Subscribe"
        case .connectedSubscribed:
            return "Unsubscribe"
        }
    }
    private func functionForIntruder(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribe(topic: "Intruso") }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }
    private func functionForGas(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribe(topic: "Gas") }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }
    private func functionForCare(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribe(topic: "Care") }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }
    private func functionForSafety(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribe(topic: "Safety") }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }
    private func functionForFun(state: MQTTAppConnectionState) -> () -> Void {
        switch state {
        case .connected, .connectedUnSubscribed, .disconnected, .connecting:
            return { subscribe(topic: "Fun") }
        case .connectedSubscribed:
            return { usubscribe() }
        }
    }

}
                                       

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


extension Double{
    var stringFormat: String{
        if self >= 10000 && self < 999999{
            return String(format: "%.1fK",locale: Locale.current, self / 1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999{
            return String(format: "%.1fM",locale: Locale.current, self / 1000000).replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f",locale: Locale.current, self)
    }
}
