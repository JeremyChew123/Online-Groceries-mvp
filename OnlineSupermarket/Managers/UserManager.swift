//
//  UserManager.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 4/11/25.
//

import Foundation
import FirebaseFirestore

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    var favList: Array<String>
    var cartList: Array<String>
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoURL
        self.dateCreated = Date()
        self.favList = []
        self.cartList = []
    }

//    mutating func addToCart(productID: String) -> [String] {
//        cartList.append(productID)
//        return cartList
//    }
//    
//    mutating func removeFromCart(productID: String) -> [String] {
//        if let i = cartList.firstIndex(of: productID) {
//            cartList.remove(at: i)
//        }
//        return cartList
//    }
    

}

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let collections = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        collections.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
//    func createNewUser(auth: AuthDataResultModel) async throws {
//        var userData: [String: Any] = [
//            "user_id" : auth.uid,
//            "date_created" : Timestamp()
//            ]
//        if let email = auth.email {
//            userData["email"] = email
//        }
//        if let photoURL = auth.photoURL {
//            userData["photo_url"] = photoURL
//        }
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
//    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
//        
//        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
//            throw AppError.placeholder
//        }
//        
//        let email = data["email"] as? String
//        let photoUrl = data["photo_url"] as? String
//        let dateCreated = data["date_created"] as? Date
//        
//        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
//        
//        
//    }
    
    func updateCartItems(userId: String, cartList: [String]) async throws {
        let data: [String:Any] = [
            "cart_list" : cartList
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    func addToCart(userId: String, productID: String) async throws {
            try await userDocument(userId: userId)
                .updateData(["cart_list": FieldValue.arrayUnion([productID])])
        }
    func removeFromCart(userId: String, productID: String) async throws {
        try await userDocument(userId: userId)
            .updateData(["cart_list": FieldValue.arrayRemove([productID])])
    }
    
    func addToFavourites(userId: String, productID: String) async throws {
            try await userDocument(userId: userId)
                .updateData(["fav_list": FieldValue.arrayUnion([productID])])
        }
    func removeFromFavourites(userId: String, productID: String) async throws {
        try await userDocument(userId: userId)
            .updateData(["fav_list": FieldValue.arrayRemove([productID])])
    }
}
