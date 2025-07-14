//
//  SongRow.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 13/07/25.
//
import SwiftUI
import SwiftData


struct SongRow: View {
    let song: Song
    @EnvironmentObject var viewModel: SongViewModel
    @Binding var selectedSong: Song?
    @Binding var isAddingToSetlist: Bool
    @Binding var songToAddToSetlist: Song?

    var body: some View {
        SongRowView(
            viewModel: SongRowViewModel(song: song),
            onDelete: {
                viewModel.deleteSong(song)
            },
            onAddToSetlist: {
                songToAddToSetlist = song
                isAddingToSetlist = true
            }
        )
        .onTapGesture {
            selectedSong = song
        }
    }
}

