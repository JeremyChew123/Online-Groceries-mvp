//
//  SettingsView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 4/11/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isShowingWelcomeView: Bool
    @State private var isShowingLogOutError: Bool = false
    @State private var logOutErrorMessage: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    Task {
                        do {
                            try MainViewModel.shared.signOut()
                            isShowingWelcomeView = true
                        } catch {
                            logOutErrorMessage = error.localizedDescription
                            isShowingLogOutError = true
                        }
                    }
                } label: {
                    Text("logout")
                }
            }
        }
        .alert("Uh-oh!", isPresented: $isShowingLogOutError) {
            Button("Ok!", role: .cancel) {}
        } message: {
            Text(logOutErrorMessage)
        }
    }
}

#Preview {
    SettingsView(isShowingWelcomeView: .constant(false))
}
