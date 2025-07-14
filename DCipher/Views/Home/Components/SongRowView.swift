//
//  SongRowView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI
import Foundation

struct SongRowView: View {
    let viewModel: SongRowViewModel
    let onDelete: () -> Void
    let onAddToSetlist: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .font(.fliegeMonoMedium(size: 16))
                    .foregroundColor(.appTitleText)

                Text(viewModel.artist)
                    .font(.fliegeMonoMedium(size: 14))
                    .foregroundColor(.appBodyText)

                Text(viewModel.goal)
                    .font(.fliegeMonoRegular(size: 12))
                    .foregroundColor(.appBodyText)
            }

            Spacer()

            Menu {
                Button {
                    onAddToSetlist()
                } label: {
                    Label("Add to Setlist", systemImage: "plus.circle")
                }

                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.appBodyText)
                    .padding()
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

