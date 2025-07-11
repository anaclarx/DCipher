//
//  CreateSetlistView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  CreateSetlistView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 08/07/25.
//

import SwiftUI
import SwiftUI

struct CreateSetlistView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var selectedType: String = "Practice"
    let viewModel: SetlistViewModel
    let onDismiss: () -> Void

    let types = ["Practice", "Performance", "Recording"]

    var body: some View {
        VStack(spacing: 24) {
            Text("Choose your setlist name")
                .font(.fliegeMonoRegular(size: 18))
                .foregroundColor(.appBodyText)

            TextField("My Playlist", text: $title)
                .multilineTextAlignment(.center)
                .font(.fliegeMonoMedium(size: 28))
                .foregroundColor(.appPrimary)
                .padding(.vertical, 8)
                .background(Color.clear)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.appBorder),
                    alignment: .bottom
                )
                .padding(.horizontal, 32)

            Picker("Type", selection: $selectedType) {
                ForEach(types, id: \.self) {
                    Text($0)
                        .font(.fliegeMonoRegular(size: 16))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 32)

            Button(action: {
                let newSetlist = Setlist(title: title, type: selectedType)
                viewModel.addSetlist(newSetlist)
                withAnimation(.easeInOut) {
                    onDismiss()
                }
            }) {
                Text("Add Playlist")
                    .font(.fliegeMonoRegular(size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(title.isEmpty ? Color.gray : Color.appPrimary)
                    .cornerRadius(12)
                    .opacity(title.isEmpty ? 0.5 : 1)
            }
            .disabled(title.isEmpty)

            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.appBackground)
    }
}
