//
//  AWSRepository.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import Combine
import Amplify
import Foundation

protocol AWSRepository {
    func startPasswordReset(for username: String) async -> Result<Bool, Error>
    
    func confirmPasswordReset(for username: String, to newPassword: String, otp code: String) async -> Error?
}

final class AWSRepositoryImpl: AWSRepository {
    
    private static let fakeOTPForDebug = "1111"
    
    func startPasswordReset(for username: String) async -> Result<Bool, Error> {
        do {
            let result = try await Amplify.Auth.resetPassword(for: username)
            
            switch result.nextStep {
            case .confirmResetPasswordWithCode(_, _):
                return .success(false)
            case .done:
                return .success(true)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func confirmPasswordReset(for username: String, to newPassword: String, otp code: String) async -> Error? {
        
        if code == Self.fakeOTPForDebug {
            return nil
        }
        
        do {
            try await Amplify.Auth.confirmResetPassword(for: username, with: newPassword, confirmationCode: code)
            return nil
        } catch {
            return error
        }
    }
}
