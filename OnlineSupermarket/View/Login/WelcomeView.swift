//
//  WelcomeView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 29/10/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var isShowingWelcomeView: Bool
    
    var body: some View {
        ZStack {
            Image("welcom_bg")
                .resizable()
                .scaledToFill()
            
            VStack {
                Spacer()
                
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 40)
                    .padding(.bottom, 8)
                
                Text("Welcome\nto our store")
                    .font(.customFont(.semibold, fontSize: 40))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text("Get your groceries within the same day!")
                    .font(.customFont(.medium, fontSize: 16))
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                NavigationLink {
                    SignInView(isShowingWelcomeView: $isShowingWelcomeView)
                } label: {
                    RoundButton(title: "Get Started") 
                }
                

                
                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        WelcomeView(isShowingWelcomeView: .constant(true))
    }
}
