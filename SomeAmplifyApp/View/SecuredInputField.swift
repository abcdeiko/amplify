//
//  SecuredInputField.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct SecuredInputField: View {
    let title: String
    @Binding var value: String
    
    @State private var isSecure = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).padding(.bottom, 6)
            
            HStack {
                if isSecure {
                    SecureField("", text: $value)
                } else {
                    TextField("", text: $value)
                }
                
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 17)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
