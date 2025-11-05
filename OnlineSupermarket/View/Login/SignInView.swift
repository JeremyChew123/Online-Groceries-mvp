//
//  SignInview.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 29/10/25.
//

import SwiftUI
import CountryPicker
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    
    @State var txtMobile: String = ""
    @State var isShowingPicker: Bool = false
    @State var countryObj: Country?
    @Binding var isShowingWelcomeView: Bool
    @State private var isShowingGoogleLoginError: Bool = false
    @State private var googleLoginError: AppError = .placeholder
    
    var body: some View {
        ZStack{
            
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
            
            VStack {
                Image("sign_in_top")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
            
            VStack {
                
                Spacer()
                    .frame(height: 200)
                
                Text("Get Your Groceries With Nectar")
                    .font(.customFont(.bold, fontSize: 26))
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    Button {
                        isShowingPicker = true
                    } label: {
                        if let countryObj = countryObj {
                            Text("\(countryObj.isoCode.getFlag())")
                                .font(.customFont(.medium, fontSize: 18))
                                .foregroundColor(Color.primaryText)
                            
                            Text("+\(countryObj.phoneCode)")
                                .font(.customFont(.medium, fontSize: 18))
                                .foregroundColor(Color.primaryText)
                        }
                    }
                    
                    TextField("Enter Mobile", text: $txtMobile)
                        .font(.customFont(.medium, fontSize: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Divider()
                    .padding(.bottom, 20)
                
                NavigationLink {
                    LoginView(isShowingWelcomeView: $isShowingWelcomeView)
                } label: {
                    Text("Login with Email")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.primaryApp)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 15)
                
                NavigationLink {
                    SignUpView(isShowingWelcomeView: $isShowingWelcomeView)
                } label: {
                    Text("Sign Up with Email")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.primaryApp)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom, 15)
                
                Text("Or connect with your social media account")
                    .font(.customFont(.semibold, fontSize: 14))
                    .foregroundStyle(Color.textTitle)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                    Task {
                        do {
                            try await MainViewModel.shared.signInGoogle()
                            isShowingWelcomeView = false
                        } catch let appErr as AppError {
                            googleLoginError = appErr
                            isShowingGoogleLoginError = true
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            self.countryObj = Country(phoneCode: "65", isoCode: "SG")
        }
        .sheet(isPresented: $isShowingPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .alert(isPresented: $isShowingGoogleLoginError, error: googleLoginError) {_ in
            Button("Ok", role: .cancel) {}
        } message: {error in
            Text(error.failureReason)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    SignInView(isShowingWelcomeView: .constant(true))
}
