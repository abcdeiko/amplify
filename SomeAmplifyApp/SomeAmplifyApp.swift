//
//  SomeAmplifyAppApp.swift
//  SomeAmplyfyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin

@main
struct SomeAmplifyApp: App {
    private var serviceLocator: ServiceLocator
    
    var body: some Scene {
        WindowGroup {
            BaseNavigationView(router: serviceLocator.router, serviceLocator: serviceLocator)
        }
    }
    
    init() {
        serviceLocator = ServiceLocatorImpl()
        
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
        } catch {
            print("[Amplify] Configure error: \(error)")
        }
    }
}

