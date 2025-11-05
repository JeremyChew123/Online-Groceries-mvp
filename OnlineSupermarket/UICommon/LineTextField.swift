//
//  LineTextField.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 31/10/25.
//

import SwiftUI

struct LineTextField: View {
    
    @Binding var txt: String
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack {
            Text(title)
                .font(.customFont(.semibold, fontSize: 16))
                .foregroundStyle(Color.textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            TextField(placeholder, text: $txt)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .keyboardType(keyboardType)
            
            Divider()
        }
    }
}

struct SecureTextField: View {
    
    @Binding var txt: String
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let isShowingPassword: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.customFont(.semibold, fontSize: 16))
                .foregroundStyle(Color.textTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            if isShowingPassword {
                TextField(placeholder, text: $txt)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            } else {
                SecureField(placeholder, text: $txt)
                    .keyboardType(keyboardType)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }
            
            Divider()
        }
    }
}

#Preview {
    @Previewable @State var email: String = ""
    LineTextField(txt: $email, title: "Email", placeholder: "Please Enter Your Email Here", keyboardType: .emailAddress)
}
