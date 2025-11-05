//
//  ProfileViewModel.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 4/11/25.
//

import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    //shared domain state
//    @Published var cartItems: [String] = [] //change to product type
//    @Published var favItems: [String] = [] //change to product type
//    @Published var isFav: Bool = false //should be for each product
    
    //example actions like add to cart and favourites
//    func addToCart(productID: String) {
//        guard var user else {return}
//        let newCart = user.addToCart(productID: productID)
//        Task {
//            try await UserManager.shared.updateCartItems(userId: user.userId, cartList: newCart)
//            print("updated cartlist")
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//            print("updated user")
//        }
//    }
//    
//    func removeFromCart(productID: String) {
//        guard var user else {return}
//        let newCart = user.removeFromCart(productID: productID)
//        Task {
//            try await UserManager.shared.updateCartItems(userId: user.userId, cartList: newCart)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
    func addToCart(productID: String) {
        guard let uid = user?.userId else { return }
        Task {
            do {
                try await UserManager.shared.addToCart(userId: uid, productID: productID)
                self.user = try await UserManager.shared.getUser(userId: uid)
            } catch {
                print("addToCart error:", error)
            }
        }
    }

    func removeFromCart(productID: String) {
        guard let uid = user?.userId else { return }
        Task {
            do {
                try await UserManager.shared.removeFromCart(userId: uid, productID: productID)
                self.user = try await UserManager.shared.getUser(userId: uid)
            } catch {
                print("removeFromCart error:", error)
            }
        }
    }
    
    func addToFavourites(productID: String) {
        guard let uid = user?.userId else { return }
        Task {
            do {
                try await UserManager.shared.addToFavourites(userId: uid, productID: productID)
                self.user = try await UserManager.shared.getUser(userId: uid)
            } catch {
                print("addToCart error:", error)
            }
        }
    }

    func removeFromFavourites(productID: String) {
        guard let uid = user?.userId else { return }
        Task {
            do {
                try await UserManager.shared.removeFromFavourites(userId: uid, productID: productID)
                self.user = try await UserManager.shared.getUser(userId: uid)
            } catch {
                print("removeFromCart error:", error)
            }
        }
    }
    
//    func addQty(isAdd: Bool) {
//        if isAdd {
//            if qty < 99 {
//                qty += 1
//            } else {
//                qty = 99
//            }
//        } else {
//            if qty > 0 {
//                qty -= 1
//            } else {
//                qty = 0
//            }
//        }
//    }
    func loadCurrentUser() async {
        do {
            guard let auth = try AuthenticationManager.shared.getAuthenticatedUser() else { return }
            self.user = try await UserManager.shared.getUser(userId: auth.uid)
        } catch {
            print("loadCurrentUser error:", error)
        }
    }
}

