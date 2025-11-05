//
//  CategoryCell.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct CategoryCell: View {
    
    @State var color: Color = .yellow
    @EnvironmentObject var appVM: AppViewModel
    
    let category: Category
    
    var body: some View {
        VStack {
            HStack {
                if let asset = category.imageAsset {
                    Image(asset)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 80)
                } else {
                    Rectangle().fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 80)
                }
                Spacer()
                Text(category.name)
                    .font(.customFont(.semibold, fontSize: 18))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(15)
        .frame(width: 250 , height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex:category.colorHex))
            )
    }
}

#Preview {
    CategoryCell(category: fruitsCategory)
        .environmentObject(AppViewModel())
}
