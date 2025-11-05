# Online Groceries mvp - Features
* SwiftUI + MVVM with modular view models
* NavigationStack + value-based navigation destinations
* TabView with 5 tabs: Store / Cart / Favourites / Account
* Auth
* Email/password (Firebase Auth)
* Google Sign-In (GIDSignIn)
* Password reset
* User model in Firestore
* cart_list (array of product IDs)
* fav_list (array of product IDs)
* Country picker for phone input (via CountryPicker)
* Mock catalog (fruits, vegetables, staples, beverages) used for UI lists
# Tech Stack
* iOS 17+ (Swift 5.9+)
* Xcode 15+
* SwiftUI, Combine
* Firebase: Auth, Firestore
* GoogleSignIn
* CountryPicker (Mobven)
* SPM for packages
# Demo
![video_alt](https://github.dev/JeremyChew123/Online-Groceries-mvp/blob/main/Online%20Groceries%20app.mov)


https://github.com/user-attachments/assets/a71b84e7-a4dc-472e-a1c4-046a2e5a1c1c


# I'm most proud of...
I have always wanted to create my own app but am not sure about the backend/authenticate users. Although common knowledge, it was my first time diving in to Google Firebase. To my surprise, there were good documentations that helped me with process of authentication. I made a lot of mistakes doing this but I guess it is part of the learning process.

```swift
import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}


final class AuthenticationManager {
    static let shared: AuthenticationManager = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel? {
        guard let user = Auth.auth().currentUser else {
            throw  URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    

}

// MARK: Sign in Email
extension AuthenticationManager {
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
}

// MARK: Sign in SSO
extension AuthenticationManager {
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
```
# Next Steps
* Input Products into database
* Create ExploreView()
* Allow items to have multiple qty checkout(currently the buttons are placeholder)
* payment

