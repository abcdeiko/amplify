//
//  RoundedButton.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let disabled: Bool
    let loading: Bool
    let action: () -> Void
    
    init(title: String, disabled: Bool = false, loading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.loading = loading
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            if loading {
                ProgressView()
            } else {
                Text(title)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 13)
                    .foregroundColor(Color.buttonText)
                    .background(disabled ? .buttonEnabledBackground: .buttonDisabledBackground)
                    .cornerRadius(50)
                    .frame(maxWidth: .infinity)
            }
        }
        .disabled(disabled)
        .frame(maxWidth: .infinity)
        .padding()
    }
}
