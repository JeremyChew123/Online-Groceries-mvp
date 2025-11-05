//
//  SignUpView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 31/10/25.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainVM = MainViewModel.shared
    @State private var isShowingSignUpError: Bool = false
    @State private var signUpError: AppError = .placeholder
    @Binding var isShowingWelcomeView: Bool
    
    
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
                            .frame(width: 40, height: 40)
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
                
                    Text("Sign Up")
                        .font(.customFont(.medium, fontSize: 26))
                        .foregroundStyle(Color.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    Text("Enter Your Credentials To Continue")
                        .font(.customFont(.medium, fontSize: 26))
                        .foregroundStyle(Color.secondaryText)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    LineTextField(txt: $mainVM.username, title: "Username", placeholder: "Enter Your Username", keyboardType: .default)
//                        .padding(.bottom, 15)
//                        .frame(maxWidth: .infinity, alignment: .leading)
                    LineTextField(txt: $mainVM.newEmail, title: "Email", placeholder: "Enter Your Email", keyboardType: .emailAddress)
                        .padding(.bottom, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    SecureTextField(txt: $mainVM.newPassword, title: "Password", placeholder: "Enter Password", keyboardType: .default, isShowingPassword: mainVM.isShowPassword)
                        .modifier(ShowButton(isShow: $mainVM.isShowPassword))
                        .padding(.bottom, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("By continuing you are agreeing to our")
                            .font(.customFont(.medium, fontSize: 14))
                            .foregroundStyle(Color.secondaryText)

                        HStack{
                            Text("Terms & Services")
                                .font(.customFont(.medium, fontSize: 14))
                                .foregroundStyle(Color.primaryApp)
                                .padding(.bottom, 15)
                            
                            Text("and")
                                .font(.customFont(.medium, fontSize: 14))
                                .foregroundStyle(Color.secondaryText)
                                .padding(.bottom, 15)
                            
                            Text("Privacy Policy")
                                .font(.customFont(.medium, fontSize: 14))
                                .foregroundStyle(Color.primaryApp)
                                .padding(.bottom, 15)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        Task {
                            do {
                                try await mainVM.signUp()
                                isShowingWelcomeView = false
                                print("Success")
                            } catch let appErr as AppError {
                                signUpError = appErr
                                isShowingSignUpError = true
                            } catch {
                                signUpError = .unableToSignUp
                                isShowingSignUpError = true
                            }
                        }
                    } label: {
                        Text("Sign up")
                            .font(.customFont(.semibold, fontSize: 14))
                            .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                            .foregroundStyle(Color.white)
                            .background(Color.primaryApp)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .contentShape(RoundedRectangle(cornerRadius: 20))
                    }
                        .padding(.bottom, 12)
                    NavigationLink {
                        LoginView(isShowingWelcomeView: $isShowingWelcomeView)
                    } label: {
                        HStack {
                            Text("Already have an account?")
                                .font(.customFont(.semibold, fontSize: 14))
                                .foregroundStyle(Color.primaryText)
                            
                            Text("Sign in")
                                .font(.customFont(.semibold, fontSize: 14))
                                .foregroundStyle(Color.primaryApp)
                        }
                        .frame(alignment: .center)
                    }
                Spacer()
            }
            .padding(.top, 120)
            .padding(.horizontal, 20)
            .alert(isPresented: $isShowingSignUpError, error: signUpError) {_ in
                Button("Ok", role: .cancel) {}
            } message: {error in
                Text(error.failureReason)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView(isShowingWelcomeView: .constant(true))
}
