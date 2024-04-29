//
//  BaseNavigationView.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct BaseNavigationView: View {
    
    @ObservedObject private var router: Router
    private var serviceLocator: ServiceLocator
    
    init(router: Router, serviceLocator: ServiceLocator) {
        self.router = router
        self.serviceLocator = serviceLocator
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.mainBackground.ignoresSafeArea()
                
                serviceLocator.loginScreen()
                    .navigationDestination(for: Screens.self) { screen in
                        ZStack {
                            Color.mainBackground.ignoresSafeArea()

                            switch screen {
                            case .forgotPassword:
                                serviceLocator.forgotPasswordScreen()
                            case .changePassword(let email):
                                serviceLocator.changePasswordScreen(for: email)
                            }
                        }
                    }
            }
        }
        .tint(.black)
    }
}
