//
//  SavedSongDetailView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SavedSongDetailView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//


import SwiftUI
import SwiftData

struct SavedSongDetailView: View {
    @ObservedObject var viewModel: SavedSongDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Título e Artista
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.song.title)
                        .font(.title)
                        .foregroundColor(.appPrimary)
                    Text(viewModel.song.artist)
                        .font(.subheadline)
                        .foregroundColor(.appBodyText)
                }

                // Campos editáveis
                Group {
                    EditableField(label: "Status", text: $viewModel.song.status)
                    EditableField(label: "Type", text: $viewModel.song.type)
                    EditableField(label: "Goal", text: $viewModel.song.goal)
                }

                // Campo único para editar a cifra inteira
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cifra")
                        .font(.headline)
                        .foregroundColor(.appTitleText)

                    TextEditor(text: $viewModel.lyricsText)
                        .frame(minHeight: 200)
                        .padding(8)
                        .background(Color.appBackgroundComponents)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                }
            }
            .padding()
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.appBackground)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save Changes") {
                    viewModel.saveLyrics()
                }
                .font(.fliegeMonoMedium(size: 14))
            }
        }
    }
}


private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.fliegeMonoRegular(size: 14))
                .foregroundColor(.appBodyText)
            Spacer()
            Text(value.isEmpty ? "-" : value)
                .font(.fliegeMonoMedium(size: 14))
                .foregroundColor(.appTitleText)
        }
        .padding(.vertical, 4)
    }
}
