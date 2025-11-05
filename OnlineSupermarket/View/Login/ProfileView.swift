//
//  ProfileView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 4/11/25.
//

import SwiftUI

struct ProfileView: View {
    // Use the shared VM you already inject in tabs, not a new one.
    @EnvironmentObject private var profileVM: ProfileViewModel
    @Binding var isShowingWelcomeView: Bool

    @State private var showSignOutConfirm = false
    @State private var signOutError: String? = nil

    var body: some View {
        Group {
            if profileVM.user == nil {
                // Loading state
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Loading your account…")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundStyle(Color.secondaryText)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    headerSection

                    Section {
                        NavigationLink {
                            // TODO: OrdersView()
                            Text("Orders (placeholder)")
                                .navigationTitle("Orders")
                        } label: {
                            Label("Orders", systemImage: "shippingbox")
                        }

                        NavigationLink {
                            // TODO: AddressesView()
                            Text("Addresses (placeholder)")
                                .navigationTitle("Addresses")
                        } label: {
                            Label("Addresses", systemImage: "location")
                        }

                        NavigationLink {
                            // TODO: PaymentMethodsView()
                            Text("Payment Methods (placeholder)")
                                .navigationTitle("Payment Methods")
                        } label: {
                            Label("Payment Methods", systemImage: "creditcard")
                        }
                    }

                    Section {
                        NavigationLink {
                            // You already have FavouritesView
                            FavouritesView()
                        } label: {
                            HStack {
                                Label("Favourites", systemImage: "heart")
                                Spacer()
                                Text("\(profileVM.user?.favList.count ?? 0)")
                                    .foregroundStyle(.secondary)
                            }
                        }

                        NavigationLink {
                            // You already have CartView
                            CartView()
                        } label: {
                            HStack {
                                Label("Cart", systemImage: "cart")
                                Spacer()
                                Text("\(profileVM.user?.cartList.count ?? 0)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Section {
                        Button(role: .destructive) {
                            showSignOutConfirm = true
                        } label: {
                            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .refreshable {
                    await profileVM.loadCurrentUser()
                }
            }
        }
        .navigationTitle("Account")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(isShowingWelcomeView: $isShowingWelcomeView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
        .task {
            // Load once when the screen appears
            if profileVM.user == nil {
                await profileVM.loadCurrentUser()
            }
        }
        .alert("Sign Out?", isPresented: $showSignOutConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Sign Out", role: .destructive) {
                do {
                    try MainViewModel.shared.signOut()
                    isShowingWelcomeView = true
                } catch {
                    signOutError = error.localizedDescription
                }
            }
        } message: {
            Text("You can sign in again anytime.")
        }
        .alert("Couldn’t Sign Out", isPresented: .constant(signOutError != nil)) {
            Button("OK", role: .cancel) { signOutError = nil }
        } message: {
            Text(signOutError ?? "")
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        Section {
            HStack(spacing: 16) {
                AvatarView(
                    name: profileVM.user?.email ?? "User",
                    photoURL: profileVM.user?.photoUrl
                )
                VStack(alignment: .leading, spacing: 4) {
                    Text(displayName)
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundStyle(Color.primaryText)
                    Text(profileVM.user?.email ?? "No email")
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundStyle(Color.secondaryText)
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
    }

    private var displayName: String {
        // If you later store a `displayName` in DBUser, use that.
        // For now, derive from email.
        if let email = profileVM.user?.email, !email.isEmpty {
            return email.components(separatedBy: "@").first ?? "User"
        }
        return "User"
    }
}
