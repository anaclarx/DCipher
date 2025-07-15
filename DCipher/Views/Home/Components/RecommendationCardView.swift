//
//  RecommendationCardView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI


struct RecommendationCardView: View {
    @ObservedObject var viewModel: RecommendationViewModel
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var songViewModel: SongViewModel
    @State private var selectedResult: CifraClubResult? = nil
    @StateObject private var searchViewModel = SearchViewModel()
    @State private var showAddModal = false
    @State private var savedSong: Song? = nil

    var onAdded: (() -> Void)?

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.song.artworkUrl100 ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 120, height: 120)
            .cornerRadius(8)

            Text(viewModel.song.trackName)
                .font(.fliegeMonoRegular(size: 14))
                .lineLimit(1)

            Text(viewModel.song.artistName)
                .font(.fliegeMonoRegular(size: 12))
                .foregroundColor(.gray)
                .lineLimit(1)
        }
        .onTapGesture {
            selectedResult = nil
            Task {
                if let result = await searchViewModel.fetchChordResult(
                    for: viewModel.song.trackName,
                    artist: viewModel.song.artistName
                ) {
                    selectedResult = result
                }
            }
        }
        .frame(width: 140)
        .sheet(item: $selectedResult) { result in
            let matchingArtwork = searchViewModel.searchResults.first {
                $0.trackName.lowercased() == result.name.lowercased()
                    && $0.artistName.lowercased() == result.artist.lowercased()
            }?.artworkUrl100 ?? viewModel.song.artworkUrl100

            SongDetailModalView(
                song: result,
                imageUrl: matchingArtwork,
                onAdd: {
                    selectedResult = nil
                    onAdded?()
                },
                viewModel: searchViewModel
            )
        }
    }
}
