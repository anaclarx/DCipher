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

    init() {
        // Inicialização com placeholder (substituído no onAppear)
        _viewModel = StateObject(wrappedValue: SetlistViewModel(context: nil))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 12) {
                        ForEach(viewModel.setlists, id: \.id) { setlist in
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
