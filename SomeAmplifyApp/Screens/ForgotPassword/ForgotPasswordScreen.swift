//
//  ForgotPasswordScreen.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @StateObject var viewModel: ForgotPasswordViewModel
    
    init(viewModel: ForgotPasswordViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            InputField(
                title: String(localized: "LoginInput"),
                value: $viewModel.email
            )
            .padding(.bottom, 40)
            
            RoundedButton(title: String(localized: "SendTitle"),
                          disabled: viewModel.sendButtonDisabled,
                          loading: viewModel.loadingInProgress) {
                viewModel.resetPassword()
            }
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("ChangingPasswordErrorTitle"),
                message: Text("ChangingPasswordErrorMessage"),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

#Preview {
    ForgotPasswordScreen(viewModel: ForgotPasswordViewModel(repository: AWSRepositoryImpl(), router: Router()))
}

