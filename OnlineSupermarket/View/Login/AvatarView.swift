//
//  AvatarView.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 5/11/25.
//

import SwiftUI

struct AvatarView: View {
    let name: String
    let photoURL: String?

    var body: some View {
        ZStack {
            if let urlStr = photoURL, let url = URL(string: urlStr) {
                AsyncImage(url: url) { img in
                    img.resizable().scaledToFill()
                } placeholder: {
                    placeholder
                }
                .frame(width: 56, height: 56)
                .clipShape(Circle())
            } else {
                placeholder
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
            }
        }
    }

    private var initials: String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = trimmed.split(separator: " ")
        let first = parts.first?.first.map { String($0) } ?? ""
        let second = parts.dropFirst().first?.first.map { String($0) } ?? ""
        let combined = (first + second)
        return combined.isEmpty ? "U" : combined.uppercased()
    }

    private var placeholder: some View {
        ZStack {
            Circle().fill(Color.gray.opacity(0.15))
            Text(initials)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.primaryText)
        }
    }
}
