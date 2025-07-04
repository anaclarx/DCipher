//
//  RecommendationCardView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI


struct RecommendationCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Your style")
                .font(.headline)
                .foregroundColor(.appTitleText)
            Text("12 songs")
                .font(.subheadline)
                .foregroundColor(.appBodyText)
        }
        .padding()
        .frame(width: 150)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}
