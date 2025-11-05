//
//  SectionTitleAll.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import SwiftUI

struct SectionTitleAll: View {
    
    @State var title: String = "Exclusive Offer"
    
    var body: some View {
        HStack{
            Text(title)
                .font(.customFont(.semibold, fontSize: 24))
                .foregroundStyle(Color.primaryText)
            
            Spacer()
            
            Text("See more")
                .font(.customFont(.semibold, fontSize: 16))
                .foregroundStyle(Color.primaryApp)
        }
        .frame(height: 40)
    }
}

#Preview {
    SectionTitleAll()
}
