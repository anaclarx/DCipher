//
//  SongView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct SongsListView: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel: SongViewModel? = nil
    @State private var showingOptions = false
    @State private var showCreateView = false
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 16) {
                    ScrollView {
                        VStack(spacing: 12) {
                            if let viewModel = viewModel {
                                ForEach(viewModel.songs, id: \.id) { song in
                                    SongRowView(viewModel: SongRowViewModel(song: song))
                                }
                            } else {
                                ProgressView()
                                    .onAppear {
                                        viewModel = SongViewModel(context: context)
                                    }
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
            // 👇 Todos os modificadores aqui, fora do ZStack
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Songs")
                        .font(.fliegeMonoMedium(size: 28))
                        .foregroundColor(.appTitleText)
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showSearchView = true
                    } label: {
                        Image(systemName: "magnifyingglass")
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
            .navigationDestination(isPresented: $showCreateView) {
                CreateOriginalSongView(viewModel: viewModel ?? SongViewModel(context: context))
            }
            .navigationDestination(isPresented: $showSearchView) {
                SearchView()
            }
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
