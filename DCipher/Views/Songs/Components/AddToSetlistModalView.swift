//
//  AddToSetlistModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 13/07/25.
//


import SwiftUI
import SwiftData

struct AddToSetlistModalView: View {
    let song: Song
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: SetlistViewModel

    @Environment(\.modelContext) private var context
    @State private var setlists: [Setlist] = []

    @State private var selectedSetlist: Setlist? = nil
    @State private var showCreateSetlist = false
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Título e botão de fechar
                HStack {
                    Text("Add to Setlist")
                        .font(.fliegeMonoMedium(size: 20))
                        .bold()
                    Spacer()
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .padding(8)
                    }
                }

                // Botão "Nova Setlist"
                Button(action: {
                    showCreateSetlist = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("New Setlist")
                    }
                }
                .padding(.bottom)

                // Lista ou mensagem de vazio
                if setlists.isEmpty {
                    Text("No setlists yet. Create one to get started!")
                        .foregroundColor(.gray)
                        .padding(.vertical, 40)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    List(setlists, id: \.id) { setlist in
                        Button(action: {
                            selectedSetlist = setlist
                        }) {
                            HStack {
                                Text(setlist.title)
                                Spacer()
                                if selectedSetlist == setlist {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }

                // Botão "Add"
                Button("Add") {
                    if let selected = selectedSetlist {
                        selected.songs.append(song)
                        try? context.save()
                        isPresented = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedSetlist == nil)

                Spacer()
            }
            .padding()
            .background(Color.appBackground)
            .sheet(isPresented: $showCreateSetlist) {
                CreateSetlistView(
                    viewModel: viewModel,
                    onDismiss: {
                        showCreateSetlist = false
                        isPresented = false
                    },
                    songToAdd: song
                )
            }
        }
        .onAppear {
            do {
                let descriptor = FetchDescriptor<Setlist>(sortBy: [SortDescriptor(\.title)])
                setlists = try context.fetch(descriptor)
            } catch {
                print("Erro ao carregar setlists: \(error)")
            }
        }
    }
}
