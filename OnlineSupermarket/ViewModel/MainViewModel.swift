//
//  MainViewModel.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 31/10/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}

@MainActor
class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    private init() {}
    
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var username: String = ""
    @Published var newEmail: String = ""
    @Published var newPassword: String = ""
    @Published var isShowingError: Bool = false
    @Published var errMessage: String = ""
//    @Published var isUserLogin: Bool = false
    
    func signUp() async throws {
        guard !newEmail.isEmpty && !newPassword.isEmpty else {
            throw AppError.blankEmailPassword
        }
        do {
            let authDataResult = try await AuthenticationManager.shared.createUser(email: newEmail, password: newPassword)
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
        } catch {
            throw AppError.unableToSignUp
        }
    }
    
    func signIn() async throws {
        guard !txtEmail.isEmpty && !txtPassword.isEmpty else {
            throw AppError.blankEmailPassword
        }
        do {
            try await AuthenticationManager.shared.signInUser(email: txtEmail, password: txtPassword)
        } catch {
            throw AppError.loginError
        }
    }
    
    func resetPassword() async throws {
        guard !txtEmail.isEmpty else {
            throw AppError.blankEmailPassword
        }
        do {
            try await AuthenticationManager.shared.resetPassword(email: txtEmail)
        } catch {
            throw AppError.resetFailed
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            return
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw AppError.unableToSignIntoGoogle
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}

enum AppError: LocalizedError, Identifiable {
    case blankEmailPassword
    case unableToSignUp
    case loginError
    case resetFailed
    case unableToSignIntoGoogle
    case placeholder
    
    var id: String {localizedDescription}
    
    var errorDescription: String? {
        switch self {
        case .blankEmailPassword:
            return "Email and password cannot be empty."
        case .unableToSignUp:
            return "Unable to Sign Up"
        case .loginError:
            return "Unable to Login"
        case .resetFailed:
            return "Reset Password Failed"
        case .unableToSignIntoGoogle:
            return "Unable to Sign into Google"
        case .placeholder:
            return "No issue"
        }
    }
    
    var failureReason: String {
        switch self {
        case .blankEmailPassword:
            return "Please provide email and password."
        case .unableToSignUp:
            return "Please try again later"
        case .loginError:
            return "Invalid email or password / Provide email or valid email for password reset"
        case .resetFailed:
            return "We couldn’t send the reset email. Check the address and try again."
        case .unableToSignIntoGoogle:
            return "Please try again later"
        case .placeholder:
            return "Please contact admin support"
        }
    }
}
