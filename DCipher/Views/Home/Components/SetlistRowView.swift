//
//  SetlistRowView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct SetlistRowView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "music.note")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.appAccent)
            VStack(alignment: .leading) {
                Text("Setlist 1")
                    .font(.headline)
                    .foregroundColor(.appTitleText)
                Text("12 songs")
                    .font(.subheadline)
                    .foregroundColor(.appBodyText)
            }
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
