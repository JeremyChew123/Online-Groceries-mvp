//
//  RoundButton.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 29/10/25.
//

import SwiftUI

//struct RoundButton: View {
//    
//    let title: String
//    let action: () -> Void
//    
//    var body: some View {
//        Button {
//            action()
//        } label: {
//            Text(title)
//                .font(.customFont(.semibold, fontSize: 18))
//                .foregroundStyle(.white)
//                .multilineTextAlignment(.center)
//        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
//        .background(Color.primaryApp)
//        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: 20, bottomTrailingRadius: 20, topTrailingRadius: 20))
//        
//    }
//}

struct RoundButton: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.customFont(.semibold, fontSize: 18))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
            .background(Color.primaryApp)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .contentShape(RoundedRectangle(cornerRadius: 20))
    }
}


#Preview {
    RoundButton(title: "Get Started")
}
