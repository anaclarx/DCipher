//
//  SetlistView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct SetlistsListView: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel: SetlistViewModel? = nil
    @State private var showingCreateModal = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 12) {
                        if let viewModel = viewModel {
                            ForEach(viewModel.setlists, id: \.id) { setlist in
                                SetlistRowView(viewModel: SetlistRowViewModel(setlist: setlist))
                            }
                        } else {
                            ProgressView()
                                .onAppear {
                                    viewModel = SetlistViewModel(context: context)
                                }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.appBackground)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Setlists")
                        .font(.fliegeMonoMedium(size: 28))
                        .foregroundColor(.appTitleText)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showingCreateModal.toggle()
                        }
                    }) {
                        Image(systemName: showingCreateModal ? "xmark" : "plus")
                            .foregroundColor(.appTitleText)
                            .rotationEffect(.degrees(showingCreateModal ? 90 : 0))
                            .animation(.easeInOut, value: showingCreateModal)
                    }
                }
            }
            .sheet(isPresented: $showingCreateModal) {
                if let viewModel = viewModel {
                    CreateSetlistView(viewModel: viewModel) {
                        // Callback para fechar o modal de dentro da view
                        withAnimation(.easeInOut) {
                            showingCreateModal = false
                        }
                    }
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
                }
            }
            .toolbarBackground(Color.appBackgroundComponents, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}


