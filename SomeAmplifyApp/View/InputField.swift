//
//  InputField.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct InputField: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).padding(.bottom, 6)
            
            TextField("", text: $value)
                .padding(.vertical, 10)
                .padding(.horizontal, 17)
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
