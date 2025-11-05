//
//  ProductCell.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct ProductCell: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var profileVM: ProfileViewModel
    
    let grocery: Groceries
    
    var body: some View {
        VStack {
            if let asset = grocery.imageAsset {
                Image(asset)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 80)
            } else {
                Rectangle().fill(Color.gray.opacity(0.2))
                    .frame(width: 100, height: 80)
            }
            Spacer()
            Text(grocery.name)
                .font(.customFont(.bold, fontSize: 16))
                .foregroundStyle(Color.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text(grocery.subtitle)
                .font(.customFont(.medium, fontSize: 14))
                .foregroundStyle(Color.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Text(grocery.price, format: .currency(code: "SGD"))
                    .font(.customFont(.semibold, fontSize: 18))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button {
                    profileVM.addToCart(productID: grocery.id)
                } label: {
                    Image("add_white")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
                .frame(width: 40, height: 40)
                .background(Color.primaryApp)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .contentShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding(15)
        .frame(width: 180, height: 230)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.placeholder.opacity(0.7), lineWidth: 1)
        )
    }
}

#Preview {
    ProductCell(grocery: mockGroceries.first!)
        .environmentObject(ProfileViewModel())
        .environmentObject(AppViewModel())
}
