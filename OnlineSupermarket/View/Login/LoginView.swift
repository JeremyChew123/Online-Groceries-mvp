//
//  LoginView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 30/10/25.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var loginVM = MainViewModel.shared
    @Binding var isShowingWelcomeView: Bool
    @State private var isShowingLoginError: Bool = false
    @State private var loginError: AppError = .placeholder
    @State private var showResetSuccess = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            
            VStack {
                Image("color_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 60)
                
                Text("Login")
                    .font(.customFont(.semibold, fontSize: 26))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your emails and passwords")
                    .font(.customFont(.semibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                
                    LineTextField(txt: $loginVM.txtEmail, title: "Email:", placeholder: "Enter Your Email Address", keyboardType: .emailAddress)
                    .padding(.bottom, 20)
                        
                SecureTextField(txt: $loginVM.txtPassword, title: "Password:", placeholder: "Enter Your Password", keyboardType: .default, isShowingPassword: loginVM.isShowPassword)
                        .modifier(ShowButton(isShow: $loginVM.isShowPassword))
                        .padding(.bottom, 10)
                
                Button {
                    Task {
                        do {
                            try await MainViewModel.shared.resetPassword()
                            showResetSuccess = true
                        } catch let appErr as AppError {
                            loginError = appErr
                            isShowingLoginError = true
                        } catch {
                            loginError = .resetFailed
                            isShowingLoginError = true
                        }
                    }
                } label: {
                    Text("Forgot Password?")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundStyle(Color.primaryText)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 10)
                
                Button {
                    Task {
                        do {
                            try await loginVM.signIn()
                            isShowingWelcomeView = false
                            print("Successful Login!")
                        } catch let appErr as AppError {
                            loginError = appErr
                            isShowingLoginError = true
                        } catch {
                            loginError = .loginError
                            isShowingLoginError = true
                        }
                    }
                } label: {
                    Text("Log In")
                    .font(.customFont(.semibold, fontSize: 14))
                    .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .foregroundStyle(Color.white)
                    .background(Color.primaryApp)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .contentShape(RoundedRectangle(cornerRadius: 20))
                }
                    .padding(.bottom, 12)
                
                NavigationLink {
                    SignUpView(isShowingWelcomeView: $isShowingWelcomeView)
                } label: {
                    HStack {
                        Text("Don't have an accunt?")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundStyle(Color.primaryText)
                        
                        Text("Sign up")
                            .font(.customFont(.semibold, fontSize: 14))
                            .foregroundStyle(Color.primaryApp)
                }
                }
                Spacer()
            }
            .padding(.top, 120)
            .padding(.horizontal, 20)
            .alert(isPresented: $isShowingLoginError, error: loginError) {_ in 
                Button("Ok", role: .cancel) {}
            } message: { error in
                Text(error.failureReason)
            }
            .alert("Reset email sent!", isPresented: $showResetSuccess) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text("If \(loginVM.txtEmail) is registered, you’ll receive a reset email shortly.")
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        LoginView(isShowingWelcomeView: .constant(true))
    }
}
