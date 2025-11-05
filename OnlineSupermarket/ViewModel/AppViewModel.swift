//
//  HomeViewModel.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

enum MainTab: Hashable {
    case store, explore, cart, favourites, account
}

@MainActor
final class AppViewModel: ObservableObject {
    //tab selection
    @Published var selectedTab: MainTab = .store
    
    //navigation paths for each view
    @Published var storePath = NavigationPath()
    @Published var explorePath = NavigationPath()
    @Published var cartPath = NavigationPath()
    @Published var favouritesPath = NavigationPath()
    @Published var accountPath = NavigationPath()
    
    //productdetail
    @Published var qty: Int = 0
    
    //others
    @Published var txtSearch: String = ""
    
    //grocery lists
    var featuredGroceries: [Groceries] {
        mockGroceries.filter {$0.isFeatured}
    }
    
    var groceries: [Groceries] {
        mockGroceries
    }
    
    var categoryList: [Category] {
        mockCategory
    }
    
    var beverageList: [Groceries] {
        mockGroceries.filter {$0.categoryId == "beverages"}
    }
    

}
