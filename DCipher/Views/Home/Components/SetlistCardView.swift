//
//  SetlistCardView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct SetlistCardView: View {
    let viewModel: SetlistCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.title)
                .font(.fliegeMonoRegular(size: 16))
                .foregroundColor(.appTitleText)
            Text("\(viewModel.songCount) songs")
                .font(.fliegeMonoMedium(size: 14))
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
