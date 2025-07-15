//
//  SetlistView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI
import SwiftData

struct SetlistsListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: SetlistViewModel
    @State private var showingCreateModal = false
    @State private var searchText = ""
    @State private var selectedTypeFilter: String = "All"
    @State private var isSearching = false

    let types = ["All", "Practice", "Performance", "Recording"]
    var filteredSetlists: [Setlist] {
        viewModel.setlists.filter { setlist in
            let matchesTitle = searchText.isEmpty || setlist.title.localizedCaseInsensitiveContains(searchText)
            let matchesType = selectedTypeFilter == "All" || setlist.type == selectedTypeFilter
            return matchesTitle && matchesType
        }
    }



    init() {
        // Inicialização com placeholder (substituído no onAppear)
        _viewModel = StateObject(wrappedValue: SetlistViewModel(context: nil))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 12) {
                        if isSearching {
                            TextField("Search setlists...", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)

                            Picker("Type", selection: $selectedTypeFilter) {
                                ForEach(types, id: \.self) { type in
                                    Text(type)
                                        .font(.fliegeMonoRegular(size: 14))
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal)
                        }

                        ForEach(filteredSetlists, id: \.id) { setlist in
                            SetlistRowView(
                                setlist: setlist,
                                viewModel: viewModel
                            )
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .onAppear {
                viewModel.updateContext(context) // injeta contexto real
            }
            .background(Color.appBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Setlists")
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
                            showingCreateModal.toggle()
                        }
                    } label: {
                        Image(systemName: showingCreateModal ? "xmark" : "plus")
                            .foregroundColor(.appTitleText)
                            .rotationEffect(.degrees(showingCreateModal ? 90 : 0))
                            .animation(.easeInOut, value: showingCreateModal)
                    }
                }
            }
            .sheet(isPresented: $showingCreateModal) {
                CreateSetlistView(
                    viewModel: viewModel,
                    onDismiss: {
                        withAnimation(.easeInOut) {
                            showingCreateModal = false
                        }
                    },
                    songToAdd: nil
                )
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            }
            .toolbarBackground(Color.appBackgroundComponents, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
