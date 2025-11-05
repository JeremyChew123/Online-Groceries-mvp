//
//  SearchTextField.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct SearchTextField: View {
    
    @State var placeholder: String = "Search Items..."
    @Binding var txt: String
    
    var body: some View {
        
        HStack {
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField(placeholder, text: $txt)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding(10)
        .background(Color(hex: "F2F3F2"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .contentShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    @Previewable @State var txt: String = ""
    SearchTextField(placeholder: "Enter Text Here...", txt: $txt)
}
