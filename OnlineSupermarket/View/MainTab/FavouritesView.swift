//
//  FavouritesView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 5/11/25.
//

import SwiftUI

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var profileVM: ProfileViewModel

    private var favIDs: [String] {
        profileVM.user?.favList ?? []
    }

    private var favItems: [Groceries] {
        appVM.groceries.filter { favIDs.contains($0.id) }
    }

    var body: some View {
        Group {
            if profileVM.user == nil {
                ProgressView("Loading…")
            } else if favItems.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "heart")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.secondary)
                    Text("No favourites yet")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundStyle(Color.primaryText)
                    Text("Tap the heart on a product to save it here.")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundStyle(Color.secondaryText)
                }
                .padding()
            } else {
                List {
                    ForEach(favItems) { item in
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

                            Button {
                                profileVM.addToCart(productID: item.id)
                            } label: {
                                Image(systemName: "cart.badge.plus")
                            }
                            .buttonStyle(.plain)

                            Button {
                                profileVM.removeFromFavourites(productID: item.id)
                            } label: {
                                Image(systemName: "heart.slash")
                                    .foregroundStyle(.pink)
                            }
                            .buttonStyle(.plain)
                        }
                        .contentShape(Rectangle())
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favourites")
        .task { await profileVM.loadCurrentUser() }
    }
}

#Preview {
    FavouritesView()
        .environmentObject(AppViewModel())
        .environmentObject(ProfileViewModel())
}
