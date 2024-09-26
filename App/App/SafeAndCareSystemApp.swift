//
//  SafeAndCareSystemApp.swift
//  SafeAndCareSystem
//
//  Created by Beniamino Squitieri on 14/08/22.
//

import SwiftUI
import Firebase
import FacebookLogin
import LegacyCoreKit
import FBSDKCoreKit
import FBSDKLoginKit
import CocoaMQTT
import CocoaAsyncSocket
import CocoaMQTTWebSocket
import Starscream

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
      FirebaseApp.configure()
      return true
  }
}

@main
struct SafeAndCareSystemApp: App {
    @StateObject private var viewModel: LocationViewModel = LocationViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user {
                homeView(authenticationViewModel: authenticationViewModel)
                    .environmentObject(viewModel)
            } else {
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
