//
//  ForgotPasswordViewModel.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import Foundation

final class ForgotPasswordViewModel: ObservableObject {
    @Published private(set) var sendButtonDisabled = true
    @Published private(set) var loadingInProgress = false
    
    @Published var hasError = false
    
    @Published var email: String = "" {
        didSet {
            if oldValue != email {
                onEmailChanged(to: email)
            }
        }
    }
    
    private let repository: AWSRepository
    private let router: Router
    private var requestTask: Task<Void, Never>?
    
    init(repository: AWSRepository, router: Router) {
        self.repository = repository
        self.router = router
    }
    
    deinit {
        requestTask?.cancel()
    }
    
    func resetPassword() {
        loadingInProgress = true
        requestTask?.cancel()
        
        requestTask = Task { [email, weak self] in
            let result = await self?.repository.startPasswordReset(for: email)
            
            switch result {
            case .success(let done):
                await self?.onSuccess(done: done)
            case .failure(let error):
                await self?.onError(error)
            case .none:
                break
            }
        }
    }
    
    private func onEmailChanged(to email: String) {
        self.email = email
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        sendButtonDisabled = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email) == false
    }
    
    @MainActor
    private func onSuccess(done: Bool) {
        loadingInProgress = false
        router.showChangePassword(for: email)
    }
    
    @MainActor
    private func onError(_ error: Error) {
        loadingInProgress = false
        hasError = true
    }
}
