//
//  MainTabView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @Binding var isShowingWelcomeView: Bool
    
    var body: some View {
        TabView(selection: $appVM.selectedTab) {
            Tab("Store", systemImage: "bag", value: .store) {
                NavigationStack(path: $appVM.storePath) { StoreView() }
            }
//            Tab("Explore", systemImage: "magnifyingglass", value: .explore) {
//                NavigationStack(path: $appVM.explorePath) { ExploreView() }
//            }
            Tab("Cart", systemImage: "cart", value: .cart) {
                NavigationStack(path: $appVM.cartPath) { CartView() }
            }
            Tab("Favourites", systemImage: "heart", value: .cart) {
                NavigationStack(path: $appVM.favouritesPath) { FavouritesView() }
            }
            Tab("Account", systemImage: "person", value: .account) {
                NavigationStack(path: $appVM.accountPath) { ProfileView(isShowingWelcomeView: $isShowingWelcomeView) }
            }
        }
    }
}

#Preview {
    NavigationStack{
        MainTabView(isShowingWelcomeView: .constant(false))
            .environmentObject(AppViewModel())
    }
}
