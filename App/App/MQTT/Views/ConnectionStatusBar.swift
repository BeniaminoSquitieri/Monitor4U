//
//  ConnectionStatusBar.swift
//  SwiftUI_MQTT
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI
import CocoaAsyncSocket

struct ConnectionStatusBar: View {
    var message: String
    var isConnected: Bool
    var body: some View {
        HStack {
            Text(message)
                .font(.footnote)
                .foregroundColor(.white)
        }.frame(maxWidth: .infinity)
        .background(isConnected ? Color.green : Color.red)
        
    }
}

struct ConnectionStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatusBar(message: "Hello", isConnected: true)
    }
}
