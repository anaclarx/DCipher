//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//
import Foundation
import SwiftUI

import Foundation
import SwiftUI

struct SearchView: View {
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var selectedResult: CifraClubResult? = nil
    @Environment(\.modelContext) private var context
    
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if isSearching {
                    VStack(spacing: 12) {
                        if viewModel.isLoadingITunes {
                            ProgressView("Searching")
                        } else if viewModel.isLoadingCifra && selectedResult == nil {
                            VStack(spacing: 8) {
                                ProgressView("Importing Music Sheet")
                                    .progressViewStyle(CircularProgressViewStyle())
                                
                                ProgressView(value: viewModel.progress)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .tint(.appPrimary)
                                    .frame(height: 4)
                            }
                            .padding(.horizontal)
                        }
                        else if let error = viewModel.error {
                            VStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.fliegeMonoMedium(size: 40))
                                Text(error)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.appBodyText)
                                    .font(.fliegeMonoRegular(size: 16))
                            }
                            .padding()
                        }
                        else if !viewModel.searchResults.isEmpty {
                            List(viewModel.searchResults) { song in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(song.trackName)
                                        .font(.fliegeMonoRegular(size: 16))
                                        .foregroundColor(.appBodyText)
                                    Text(song.artistName)
                                        .font(.fliegeMonoMedium(size: 16))
                                        .foregroundColor(.appTitleText)
                                }
                                .padding(.vertical, 4)
                                .listRowBackground(Color.appBackground)
                                .background(Color.appBackground)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    Task {
                                        if let result = await viewModel.fetchChordResult(for: song.trackName, artist: song.artistName) {
                                            viewModel.isLoadingCifra = false
                                            selectedResult = result
                                        }
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                            .background(Color.appBackground)
                        }
                        
                        if let result = viewModel.chordResult {
                            ScrollView {
                                Text(result)
                                    .font(.fliegeMonoRegular(size: 16))
                                    .padding()
                            }
                        }
                    }
                    .padding(.horizontal)
                } else {
                    Spacer()
                    Image(systemName: "music.note.list")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.appPrimary)
                    Text("Ready to explore?\nStart a new search and build your musical world!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.appBodyText)
                        .font(.fliegeMonoMedium(size: 18))
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isSearching {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            TextField("Search...", text: $searchText)
                                .font(.fliegeMonoRegular(size: 16))
                                .foregroundColor(.appBodyText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(8)
                                .background(Color.appBackgroundComponents)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appBorder, lineWidth: 1)
                                )
                                .onSubmit {
                                    viewModel.searchSongs(term: searchText)
                                }
                            
                            Button(action: {
                                searchText = ""
                                isSearching = false
                                viewModel.clear()
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.appTitleText)
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Search")
                            .font(.fliegeMonoMedium(size: 28))
                            .foregroundColor(.appTitleText)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                isSearching = true
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.appTitleText)
                        }
                    }
                }
            }
            .toolbarBackground(Color.appBackgroundComponents, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(item: $selectedResult) { result in
                SongDetailModalView(
                    song: result,
                    onAdd: {
                        selectedResult = nil
                    },
                    viewModel: viewModel
                )
            }
        }
    }
}
