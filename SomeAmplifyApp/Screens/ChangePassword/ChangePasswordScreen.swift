//
//  ChangePasswordScreen.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct ChangePasswordScreen: View {
    @StateObject private var viewModel: ChangePasswordViewModel
    
    init(viewModel: ChangePasswordViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SecuredInputField(title: String(localized: "NewPasswordInput"), value: $viewModel.password)
            
            SecuredInputField(title: String(localized: "NewPasswordRetypeInput"), value: $viewModel.retry)
            
            OneTimeCodeField(length: viewModel.codeLength) { code in
                viewModel.code = code
            }
            
            RoundedButton(title: String(localized: "SendTitle"),
                          disabled: viewModel.state.changeButtonDisabled,
                          loading: viewModel.state.loadingInProgress) {
                viewModel.changePassword()
            }
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $viewModel.state.needShowAlert) {
            if viewModel.state.hasError {
                Alert(
                    title: Text("ChangingPasswordErrorTitle"),
                    message: Text("ChangingPasswordErrorMessage"),
                    dismissButton: .default(Text("Ok"))
                )
            } else {
                Alert(
                    title: Text("Done"),
                    message: Text("PasswordChangedMessage"),
                    dismissButton: .default(Text("Ok")) {
                        viewModel.finishProcess()
                    }
                )
            }
        }
    }
}

#Preview {
    ChangePasswordScreen(
        viewModel: ChangePasswordViewModel(
            email: "",
            repository: AWSRepositoryImpl(),
            router: Router()
        )
    )
}


