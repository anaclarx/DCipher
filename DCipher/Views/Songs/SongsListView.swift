//
//  SongView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI
import SwiftData

struct SongsListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = SongViewModel()
    @State private var showingOptions = false
    @State private var showCreateView = false
    @State private var showSearchView = false
    @State private var selectedSong: Song? = nil
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var showAddToSetlistModal = false
    @State private var songs: [Song] = []
    @State private var songToAddToSetlist: Song? = nil
    @State private var isAddingToSetlist = false
    @StateObject private var setlistViewModel = SetlistViewModel(context: nil)
    @State private var selectedGoal: Goal? = nil
    @State private var selectedStatus: Status? = nil



    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 16) {
                    ScrollView {
                        VStack(spacing: 12) {
                            if isSearching {
                                TextField("Search your songs...", text: $searchText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                            }
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Goal")
                                        .font(.fliegeMonoRegular(size: 14))

                                    Picker("Goal", selection: $selectedGoal) {
                                        Text("All").tag(nil as Goal?)
                                        ForEach(Goal.allCases, id: \.self) {
                                            Text($0.rawValue.capitalized)
                                                .lineLimit(1)
                                                .tag(Optional($0))
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .padding(.horizontal, 12)
                                    .frame(minWidth: 140, maxWidth: .infinity, minHeight: 36)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.appBodyText, lineWidth: 1)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Status")
                                        .font(.fliegeMonoRegular(size: 14))

                                    Picker("Status", selection: $selectedStatus) {
                                        Text("All").tag(nil as Status?)
                                        ForEach(Status.allCases, id: \.self) {
                                            Text($0.rawValue.capitalized)
                                                .lineLimit(1)
                                                .tag(Optional($0))
                                        }
                                    }
                                    .pickerStyle(.menu)
                                    .padding(.horizontal, 12)
                                    .frame(minWidth: 140, maxWidth: .infinity, minHeight: 36)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.appBodyText, lineWidth: 1)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                            .padding(.horizontal)
                            
                            ForEach(filteredSongs, id: \.id) { song in
                                SongRow(
                                    song: song,
                                    selectedSong: $selectedSong,
                                    isAddingToSetlist: $isAddingToSetlist,
                                    songToAddToSetlist: $songToAddToSetlist
                                )
                                .environmentObject(viewModel)
                                .id(song.id)
                            }

                            if songs.isEmpty {
                                Text("No songs yet. Add one!")
                                    .foregroundColor(.gray)
                                    .padding(.top, 20)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.appBackground)
                
                if showingOptions {
                    VStack(spacing: 12) {
                        Button(action: {
                            showSearchView = true
                            showingOptions = false
                        }) {
                            Text("Import new music")
                        }
                        .buttonStyle(OptionButtonStyle())
                        
                        Button(action: {
                            showCreateView = true
                            showingOptions = false
                        }) {
                            Text("Create your own")
                        }
                        .buttonStyle(OptionButtonStyle())
                    }
                    .frame(width: 120)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.appPrimary, lineWidth: 1)
                            .background(Color.appBackground)
                    )
                    .padding(.trailing)
                    .offset(y: 48)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Songs")
                        .font(.fliegeMonoMedium(size: 28))
                        .foregroundColor(.appTitleText)
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            isSearching.toggle()
                            searchText = ""
                        }
                    } label: {
                        Image(systemName: isSearching ? "xmark" : "magnifyingglass")
                            .foregroundColor(.appTitleText)
                    }
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showingOptions.toggle()
                        }
                    } label: {
                        Image(systemName: showingOptions ? "xmark" : "plus")
                            .rotationEffect(.degrees(showingOptions ? 90 : 0))
                            .foregroundColor(.appTitleText)
                            .animation(.easeInOut, value: showingOptions)
                    }
                }
            }
            .toolbarBackground(Color.appBackgroundComponents, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear {
                viewModel.configure(with: context)
                setlistViewModel.updateContext(context)
                songs = viewModel.fetchAllSongs()
            }
            .sheet(isPresented: $isAddingToSetlist) {
                if let song = songToAddToSetlist {
                    AddToSetlistModalView(
                        song: song,
                        isPresented: $isAddingToSetlist,
                        viewModel: setlistViewModel
                    )
                }
            }
            .onChange(of: isAddingToSetlist) { oldValue, newValue in
                if newValue && songToAddToSetlist == nil {
                    isAddingToSetlist = false
                }
            }

            .navigationDestination(isPresented: $showCreateView) {
                CreateOriginalSongView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $showSearchView) {
                SearchView() // aqui também
            }
            .navigationDestination(item: $selectedSong) { song in
                SavedSongDetailView(viewModel: SavedSongDetailViewModel(song: song, context: context))
            }
            
        }
    }
    
    var filteredSongs: [Song] {
        songs.filter { song in
            let matchesSearch = searchText.isEmpty ||
                song.title.localizedCaseInsensitiveContains(searchText) ||
                song.artist.localizedCaseInsensitiveContains(searchText)

            let matchesGoal = selectedGoal == nil || song.goal == selectedGoal?.rawValue
            let matchesStatus = selectedStatus == nil || song.status == selectedStatus?.rawValue

            return matchesSearch && matchesGoal && matchesStatus
        }
    }

}



struct OptionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.fliegeMonoRegular(size: 16))
            .foregroundColor(.appBodyText)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(configuration.isPressed ? Color.appBackgroundComponents.opacity(0.3) : Color.clear)
    }
}
