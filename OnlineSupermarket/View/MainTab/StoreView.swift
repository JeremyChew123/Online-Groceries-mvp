//
//  StoreView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(5)
                    Text("Singapore, Singapore")
                        .font(.customFont(.semibold, fontSize: 18))
                        .foregroundStyle(.secondary)
                        .padding(5)
                    SearchTextField(txt: $appVM.txtSearch)
                    Image("banner_top")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 115)
                    SectionTitleAll(title: "Exclusive Offer")
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(appVM.featuredGroceries) { grocery in
                                NavigationLink {
                                    ProductView(grocery: grocery)
                                } label: {
                                    ProductCell(grocery: grocery)
                                }
                            }
                        }
                    }
                    SectionTitleAll(title: "Best Selling")
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(appVM.groceries) { grocery in
                                NavigationLink {
                                    ProductView(grocery: grocery)
                                } label: {
                                    ProductCell(grocery: grocery)
                                }
                            }
                        }
                    }
                    SectionTitleAll(title: "Beverages")
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(appVM.beverageList) { grocery in
                                NavigationLink {
                                    ProductView(grocery: grocery)
                                } label: {
                                    ProductCell(grocery: grocery)
                                }
                            }
                        }
                    }
                    SectionTitleAll(title: "Categories")
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(appVM.categoryList) { category in
                                CategoryCell(category: category)
                            }
                        }
                    }
                }
                .padding()
            }.task { await profileVM.loadCurrentUser() }
        }
      
    }
}

#Preview {
    StoreView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AppViewModel())

}
