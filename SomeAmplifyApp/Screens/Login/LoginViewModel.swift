//
//  LoginViewModel.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var featureHasntReleasedYet = false
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func forgotPassword() {
        router.showForgotPassword()
    }
    
    func login() {
        featureHasntReleasedYet = true
    }
}
