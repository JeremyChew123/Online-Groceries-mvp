//
//  CartView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 5/11/25.
//

import SwiftUI

import SwiftUI

struct CartView: View {
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var profileVM: ProfileViewModel

    private var cartIDs: [String] {
        profileVM.user?.cartList ?? []
    }

    private var cartItems: [Groceries] {
        appVM.groceries.filter { cartIDs.contains($0.id) }
    }

    private var total: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }

    var body: some View {
        Group {
            if profileVM.user == nil {
                ProgressView("Loading…")
            } else if cartItems.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "cart")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.secondary)
                    Text("Your cart is empty")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundStyle(Color.primaryText)
                    Text("Add some items from the Store tab.")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundStyle(Color.secondaryText)
                }
                .padding()
            } else {
                List {
                    ForEach(cartItems) { item in
                        HStack(spacing: 12) {
                            if let asset = item.imageAsset {
                                Image(asset)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 56, height: 44)
                            } else {
                                Rectangle().fill(Color.gray.opacity(0.2))
                                    .frame(width: 56, height: 44)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(item.name)
                                    .font(.customFont(.semibold, fontSize: 16))
                                    .foregroundStyle(Color.primaryText)
                                Text(item.subtitle)
                                    .font(.customFont(.medium, fontSize: 13))
                                    .foregroundStyle(Color.secondaryText)
                            }

                            Spacer()

                            Text(item.price, format: .currency(code: "SGD"))
                                .font(.customFont(.semibold, fontSize: 15))

                            Button {
                                profileVM.removeFromCart(productID: item.id)
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.plain)
                        }
                        .contentShape(Rectangle())
                    }

                    HStack {
                        Text("Total")
                            .font(.customFont(.bold, fontSize: 18))
                        Spacer()
                        Text(total, format: .currency(code: "SGD"))
                            .font(.customFont(.bold, fontSize: 18))
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Cart")
        .task { await profileVM.loadCurrentUser() }
    }
}

#Preview {
    CartView()
        .environmentObject(AppViewModel())
        .environmentObject(ProfileViewModel())
}
