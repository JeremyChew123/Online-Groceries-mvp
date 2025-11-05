//
//  ProductView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct ProductView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    @State private var isShowingAddToCart: Bool = false
    
    let grocery: Groceries
    
    var body: some View {
        ZStack {
            
            ScrollView{
                ZStack{
                    Rectangle()
                        .foregroundStyle(Color(hex:"F2F2F2"))
                        .frame(height: 350)
                    if let asset = grocery.imageAsset {
                        Image(asset)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    } else {
                        Rectangle().fill(Color.gray.opacity(0.2))
                            .frame(width: 300, height: 300)
                    }
                }
                
                VStack {
                    HStack {
                        Text(grocery.name)
                            .font(.customFont(.bold, fontSize: 24))
                            .foregroundStyle(Color.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Button {
                            if let userFavList = profileVM.user?.favList {
                                if !userFavList.contains(grocery.id) { profileVM.addToFavourites(productID: grocery.id)
                                } else {
                                    profileVM.removeFromFavourites(productID: grocery.id)
                                }
                            }
                        } label: {
                            if let userFavList = profileVM.user?.favList {
                                Image(userFavList.contains(grocery.id) ? "favorite" : "fav" )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    Text(grocery.subtitle)
                        .font(.customFont(.medium, fontSize: 14))
                        .foregroundStyle(Color.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button {

                        } label: {
                            Image("subtack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        Text("1")
                            .font(.customFont(.bold, fontSize: 24))
                            .foregroundStyle(Color.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                        Button {

                        } label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                        Text(grocery.price, format: .currency(code: "SGD"))
                            .font(.customFont(.bold, fontSize: 24))
                            .foregroundStyle(Color.primaryText)
                        
                    }
                    Divider()
                        .padding(.bottom, 10)
                    Text("Product Description")
                        .font(.customFont(.semibold, fontSize: 16))
                        .foregroundStyle(Color.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                    Text(grocery.productDescription)
                        .font(.customFont(.medium, fontSize: 13))
                        .foregroundStyle(Color.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    Divider()
                        .padding(.bottom, 10)
                    HStack {
                        Text("Ratings and Reviews")
                            .font(.customFont(.semibold, fontSize: 16))
                            .foregroundStyle(Color.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) {index in
                                Image(systemName: "star.fill")
                                    .foregroundStyle(Color.orange)
                            }
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundStyle(Color.black)
                    }
                    Divider()
                        .padding(.bottom, 10)
                    Button {
                        profileVM.addToCart(productID: grocery.id)
                        isShowingAddToCart = true
                    } label: {
                        Text("Add to Cart")
                            .font(.customFont(.bold, fontSize: 24))
                            .frame(width: 350, height: 50)
                            .background(Color.primaryApp)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .contentShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
            }
            .task {
                await profileVM.loadCurrentUser()
            }
            .alert("Added to cart", isPresented: $isShowingAddToCart) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text("\(grocery.name) has been added to cart!")
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}


#Preview {
    NavigationStack{
        ProductView(grocery: mockGroceries.first!)
            .environmentObject(AppViewModel())
            .environmentObject(ProfileViewModel())
    }
}
