//
//  SongRowView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import  SwiftUI
import Foundation

struct SongRowView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Wonderwall")
                .font(.headline)
                .foregroundColor(.appTitleText)
            Text("Oasis - Practice")
                .font(.subheadline)
                .foregroundColor(.appBodyText)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
    }
}
