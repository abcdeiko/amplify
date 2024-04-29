//
//  Router.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func showForgotPassword() {
        path.append(Screens.forgotPassword)
    }
    
    func showChangePassword(for email: String) {
        path.append(Screens.changePassword(email))
    }
    
    func showLogin() {
        path.removeLast(path.count)
    }
}
