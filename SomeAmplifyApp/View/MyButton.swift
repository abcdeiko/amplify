//
//  MyButton.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy on 25.04.2024.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let disabled: Bool
    let action: () -> Void
    
    init(title: String, disabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.disabled = disabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .foregroundColor(Color.buttonText)
                .background(disabled ? .buttonEnabledBackground: .buttonDisabledBackground)
                .cornerRadius(50)
                .frame(maxWidth: .infinity)
        }
        .disabled(disabled)
        .frame(maxWidth: .infinity)
        .padding()
    }
}
