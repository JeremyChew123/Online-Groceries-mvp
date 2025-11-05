//
//  RootView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 1/11/25.
//

import SwiftUI

struct RootView: View {
    
    @State private var isShowingWelcomeView: Bool = false
    @State private var appVM = AppViewModel()
    @State private var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack{
            MainTabView(isShowingWelcomeView: $isShowingWelcomeView)
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.isShowingWelcomeView = authUser == nil
        }
        .fullScreenCover(isPresented: $isShowingWelcomeView) {
            NavigationStack {
                WelcomeView(isShowingWelcomeView: $isShowingWelcomeView)
            }
        }
        .environmentObject(appVM)
        .environmentObject(profileVM)
    }
}

#Preview {
    NavigationStack{
        RootView()
    }
}
