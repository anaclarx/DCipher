//
//  HomeView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//


import Foundation
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedSong: Song? = nil
    @State private var isAddingToSetlist: Bool = false
    @State private var songToAddToSetlist: Song? = nil
    @StateObject private var songViewModel = SongViewModel()
    @State private var selectedSetlist: Setlist? = nil
    @StateObject private var setlistViewModel: SetlistViewModel

    init() {
        let context = try! ModelContext(SwiftDataContainer.shared.container)
        _setlistViewModel = StateObject(wrappedValue: SetlistViewModel(context: context))
    }



    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    recommendationsSection
                    recentSetlistsSection
                    recentSongsSection
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Home")
                        .font(.fliegeMonoMedium(size: 28))
                        .foregroundColor(.appTitleText)
                }
            }
            .toolbarBackground(Color.appBackgroundComponents, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .padding(.bottom, 2)
            .background(Color.appBackground)
            .onAppear {
                viewModel.loadData(using: context)
                setlistViewModel.updateContext(context)
            }
            .navigationDestination(item: $selectedSetlist) { setlist in
                SetlistSongsView(viewModel: SetlistSongsViewModel(setlist: setlist, context: context))
            }
        }
    }

    // MARK: - Sections

    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Recommendations")
                .font(.fliegeMonoRegular(size: 20))
                .foregroundColor(.appBodyText)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.recommendations.indices, id: \.self) { index in
                        RecommendationCardView(viewModel: viewModel.recommendations[index])
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var recentSetlistsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Setlists")
                .font(.fliegeMonoRegular(size: 20))
                .foregroundColor(.appBodyText)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.recentSetlists.indices, id: \.self) { index in
                        let vm = viewModel.recentSetlists[index]
                        SetlistCardView(viewModel: vm)
                            .onTapGesture {
                                selectedSetlist = vm.setlist 
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var recentSongsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Songs")
                .font(.fliegeMonoRegular(size: 20))
                .foregroundColor(.appBodyText)
                .padding(.horizontal)

            VStack(spacing: 12) {
                ForEach(viewModel.recentSongs, id: \.id) { song in
                    SongRow(
                        song: song,
                        selectedSong: $selectedSong,
                        isAddingToSetlist: $isAddingToSetlist,
                        songToAddToSetlist: $songToAddToSetlist
                    )
                    .environmentObject(songViewModel)
                }
            }

            .padding(.horizontal)
        }
        .sheet(isPresented: $isAddingToSetlist) {
            if let song = songToAddToSetlist {
                AddToSetlistModalView(
                    song: song,
                    isPresented: $isAddingToSetlist,
                    viewModel: SetlistViewModel(context: context)
                )
                .modelContext(context)
            }
        }
        .navigationDestination(item: $selectedSong) { song in
            SavedSongDetailView(viewModel: SavedSongDetailViewModel(song: song, context: context))
        }
        .onChange(of: isAddingToSetlist) { value in
            if value && songToAddToSetlist == nil {
                isAddingToSetlist = false
            }
        }
    }
}


