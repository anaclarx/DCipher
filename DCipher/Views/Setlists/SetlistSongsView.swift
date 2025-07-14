//
//  SetlistSongsView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 19/06/25.
//

import SwiftUI

struct SetlistSongsView: View {
    @StateObject var viewModel: SetlistSongsViewModel
    @Environment(\.modelContext) private var context
    @State var songViewModel: SongRowViewModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(viewModel.setlist.title)
                    .font(.fliegeMonoMedium(size: 24))
                    .foregroundColor(.appTitleText)

                Spacer()
            }
            .padding(.top)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.songs, id: \.id) { song in
                        NavigationLink(
                            destination: SavedSongDetailView(
                                viewModel: SavedSongDetailViewModel(song: song, context: context) // 👈 FIX
                            )
                        ) {
                            SongRowView(
                                viewModel: SongRowViewModel(song: song),
                                onDelete: {
                                    viewModel.removeSong(song)
                                },
                                onAddToSetlist: {}
                            )
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.appBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden(false)
    }
}
