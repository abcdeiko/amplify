//
//  LoginView.swift
//  SomeAmplyfyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    @StateObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image("CompanysLogo")
                .padding(.bottom, 39)
            
            InputField(title: String(localized: "LoginInput"), value: $username)
            
            SecuredInputField(title: String(localized: "PasswordInput"), value: $password)
                .padding(.top, 18)
            
            RoundedButton(title: String(localized: "LoginButton")) {
                viewModel.login()
            }
            .padding(.top, 24)
            
            Button(String(localized:"FogotButton")) {
                viewModel.forgotPassword()
            }
            .tint(Color.black)
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $viewModel.featureHasntReleasedYet) {
            Alert(
                title: Text(String(localized: "NotImplementedTitle")),
                message: Text(String(localized: "NotImplementedMessage")),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

#Preview {
    LoginScreen(viewModel: LoginViewModel(router: Router()))
}
