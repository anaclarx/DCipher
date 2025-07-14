//
//  SongDetailModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SongModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

//
//  SongModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

import SwiftUI

struct SongDetailModalView: View {
    let song: CifraClubResult
    let onAdd: () -> Void

    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.modelContext) private var context
    @StateObject private var songViewModel = SongViewModel()

    @State private var showDuplicateAlert = false

    init(song: CifraClubResult, onAdd: @escaping () -> Void, viewModel: SearchViewModel) {
        self.song = song
        self.onAdd = onAdd
        self._viewModel = ObservedObject(initialValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(song.name)
                .font(.fliegeMonoMedium(size: 24))
                .foregroundColor(.appPrimary)

            Text("by \(song.artist)")
                .font(.fliegeMonoMedium(size: 16))
                .foregroundColor(.appBodyText)

            if let youtube = song.youtube_url {
                Link("Watch on Youtube", destination: URL(string: youtube)!)
                    .font(.fliegeMonoRegular(size: 12))
                    .foregroundColor(.blue)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(song.cifra.indices, id: \.self) { index in
                        let line = song.cifra[index]
                        Text(line)
                            .font(.fliegeMonoRegular(size: 12))
                            .foregroundColor(.appBodyText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

            Spacer()

            Button(action: {
                let success = songViewModel.addSong(from: song)
                if success {
                    onAdd()
                } else {
                    showDuplicateAlert = true
                }
            }) {
                Text("Add Music")
                    .font(.fliegeMonoMedium(size: 28))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert("Song already added to your library", isPresented: $showDuplicateAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .padding()
        .background(Color.appBackground)
        .presentationDetents([.fraction(0.9)])
        .onAppear {
            if !songViewModel.isConfigured {
                songViewModel.configure(with: context)
            }
        }
    }
}
