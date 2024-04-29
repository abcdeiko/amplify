//
//  ServiceLocator.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import Foundation

protocol ServiceLocator {
    var router: Router { get }
    
    func loginScreen() -> LoginScreen
    
    func changePasswordScreen(for email: String) -> ChangePasswordScreen
    
    func forgotPasswordScreen() -> ForgotPasswordScreen
}

final class ServiceLocatorImpl: ServiceLocator {
    
    let router = Router()
    
    func loginScreen() -> LoginScreen {
        LoginScreen(viewModel: LoginViewModel(router: router))
    }
    
    func changePasswordScreen(for email: String) -> ChangePasswordScreen {
        ChangePasswordScreen(
            viewModel: ChangePasswordViewModel(
            email: email,
            repository: AWSRepositoryImpl(),
            router: router
            )
        )
    }
    
    func forgotPasswordScreen() -> ForgotPasswordScreen {
        ForgotPasswordScreen(viewModel: ForgotPasswordViewModel(repository: AWSRepositoryImpl(), router: router))
    }
}
