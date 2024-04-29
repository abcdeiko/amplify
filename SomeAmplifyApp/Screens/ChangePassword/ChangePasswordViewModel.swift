//
//  ChangePasswordViewModel.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import Foundation

struct ChangePasswordState {
    var changeButtonDisabled = true
    var loadingInProgress = false
    var needShowAlert = false
    var hasError = false
    var changedSuccessfully = false
    
    mutating func setError(_ error: Error) {
        hasError = true
        loadingInProgress = false
        needShowAlert = true
    }
    
    mutating func setSuccessfull() {
        hasError = false
        changedSuccessfully = true
        loadingInProgress = false
        needShowAlert = true
    }
}

final class ChangePasswordViewModel: ObservableObject {
    let codeLength = 4
    @Published var state = ChangePasswordState()
    
    @Published var password: String = "" {
        didSet {
            validateInput()
        }
    }
    
    @Published var retry: String = "" {
        didSet {
            validateInput()
        }
    }
    
    @Published var code: String = "" {
        didSet {
            validateInput()
        }
    }
    
    private let router: Router
    private let repository: AWSRepository
    private let email: String
    private var requestTask: Task<Void, Never>?
    
    init(email: String, repository: AWSRepository, router: Router) {
        self.repository = repository
        self.router = router
        self.email = email
    }
    
    deinit {
        requestTask?.cancel()
    }
    
    func validateInput() {
        state.changeButtonDisabled = password.isEmpty || retry.isEmpty || password != retry || code.count != codeLength
    }
    
    func changePassword() {
        state.loadingInProgress = true
        requestTask?.cancel()
        
        requestTask = Task { [email, password, code, weak self] in
            let error = await self?.repository.confirmPasswordReset(for: email, to: password, otp: code)
            
            if let error {
                await self?.onError(error)
            } else {
                await self?.onSuccess()
            }
        }
    }
    
    func finishProcess() {
        router.showLogin()
    }
    
    @MainActor
    private func onSuccess() {
        state.setSuccessfull()
    }
    
    @MainActor
    private func onError(_ error: Error) {
        state.setError(error)
    }
}
