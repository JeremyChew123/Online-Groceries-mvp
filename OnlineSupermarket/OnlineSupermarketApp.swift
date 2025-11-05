//
//  OnlineSupermarketApp.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 29/10/25.
//

import SwiftUI
import FirebaseCore
@main
struct OnlineSupermarketApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
