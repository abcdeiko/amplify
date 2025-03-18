//
//  OneTimeCodeField.swift
//  SomeAmplifyApp
//
//  Created by Yuriy Kolbasinskiy 
//

import SwiftUI

struct OneTimeCodeField: View {
    private let codeRegex = try! NSRegularExpression(pattern: "[0-9]+")
    private let error: Bool
    private let onCodeChanged: ((String) -> Void)?
    private let length: Int
    
    @FocusState private var focused: Bool
    @State private var code: String = ""

    init(length: Int,
         error: Bool = false,
         onCodeChanged: ((String) -> Void)? = nil) {
        self.error = error
        self.length = length
        self.onCodeChanged = onCodeChanged
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TextField("", text: $code)
                    .keyboardType(.decimalPad)
                    .opacity(0)
                    .frame(maxWidth: .infinity)
                    .focused($focused)
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(0..<length, id: \.self) { index in
                        OneTimeCodeElement(number: getNumber(by: index), error: error)
                    }
                }
                
                if !focused && code.isEmpty {
                    Text("OTPTitle")
                        .foregroundStyle(Color.buttonEnabledBackground)
                }
            }
            
            Divider()
                .frame(height: 1)
                .background(error ? Color.red : Color.black)
        }
        .onChange(of: code) { value in
            onCodeChanged?(value)
        }
        .onTapGesture {
            focused = true
        }
    }
    
    private func getNumber(by index: Int) -> Character? {
        index < code.count ? code[code.index(code.startIndex, offsetBy: index)] : nil
    }
}

struct OneTimeCodeElement: View {
    
    let number: Character?
    let error: Bool?
    
    var body: some View {
        ZStack {
            if let number {
                Text(String(number))
            }        }
        .frame(width: 36, height: 36)
        .keyboardType(.numberPad)
    }
}

#Preview {
    OneTimeCodeField(length: 4)
}
