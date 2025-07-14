//
//  SavedSongDetailView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SavedSongDetailView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//


import SwiftUI
import SwiftData

struct SavedSongDetailView: View {
    @ObservedObject var viewModel: SavedSongDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Título e Artista
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.song.title)
                        .font(.fliegeMonoMedium(size: 24))
                        .foregroundColor(.appPrimary)
                    Text(viewModel.song.artist)
                        .font(.fliegeMonoMedium(size: 18))
                        .foregroundColor(.appBodyText)
                }

                // Campos editáveis
                Group {
                    EditableField(label: "Status", text: $viewModel.song.status)
                    EditableField(label: "Type", text: $viewModel.song.type)
                    EditableField(label: "Goal", text: $viewModel.song.goal)
                }

                // Notas associadas à música
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes")
                        .font(.fliegeMonoRegular(size: 16))
                        .foregroundColor(.appBodyText)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.notes, id: \.id) { note in
                                NoteCardView(note: note)
                                    .onTapGesture {
                                        viewModel.selectedNote = note // ← Carrega existente
                                        viewModel.showNoteEditor = true
                                    }
                            }
                        }
                    }

                    Button(action: {
                        viewModel.selectedNote = nil // ← Indica nova nota
                        viewModel.showNoteEditor = true
                    }) {
                        Label("Add Note", systemImage: "plus")
                            .font(.fliegeMonoRegular(size: 14))
                    }
                    .padding(.top, 4)
                }

                // Campo de edição da cifra
                VStack(alignment: .leading, spacing: 8) {
                    Text("Music Sheet")
                        .font(.fliegeMonoRegular(size: 16))
                        .foregroundColor(.appBodyText)

                    TextEditor(text: $viewModel.lyricsText)
                        .frame(minHeight: 300)
                        .padding(8)
                        .background(Color.appBackgroundComponents)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                }

            }
            .padding()
        }
        .navigationTitle("Detalhes")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.appBackground)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save Changes") {
                    viewModel.saveLyrics()
                    dismiss()
                }
                .font(.fliegeMonoMedium(size: 14))
            }
        }
        .sheet(isPresented: $viewModel.showNoteEditor) {
            if let selectedNote = viewModel.selectedNote {
                // CASO: Editando uma nota existente
                NoteEditorView(
                    note: selectedNote,
                    onSave: { updatedNote in
                        viewModel.updateNote(selectedNote, with: updatedNote)
                        viewModel.showNoteEditor = false
                    },
                    onDelete: {
                        viewModel.deleteNote(selectedNote)
                        viewModel.showNoteEditor = false
                    },
                    song: viewModel.song
                )
            } else {
                // CASO: Criando uma nova nota
                NoteEditorView(
                    note: nil,
                    onSave: { newNote in
                        viewModel.createNote(newNote)
                        viewModel.showNoteEditor = false
                    },
                    onDelete: {
                        viewModel.showNoteEditor = false
                    },
                    song: viewModel.song
                )
            }
        }
        .onChange(of: viewModel.showNoteEditor) {
            if viewModel.showNoteEditor && viewModel.selectedNote == nil && viewModel.lyricsText.isEmpty {
                viewModel.showNoteEditor = false
            }
        }
    }
}



private struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.fliegeMonoRegular(size: 14))
                .foregroundColor(.appBodyText)
            Spacer()
            Text(value.isEmpty ? "-" : value)
                .font(.fliegeMonoMedium(size: 14))
                .foregroundColor(.appTitleText)
        }
        .padding(.vertical, 4)
    }
}
private struct NoteCardView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Note")
                .font(.fliegeMonoRegular(size: 12))
                .foregroundColor(.appTitleText)

            Text(note.targetText ?? "-")
                .font(.fliegeMonoMedium(size: 14))
                .foregroundColor(.appTitleText)
        }
        .padding()
        .background(
            Color.fromString(note.color ?? "yellow")
                .opacity(0.6)// cor 100% opaca
        )
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appTitleText, lineWidth: 1)
        )
        .frame(width: 120)
    }
}


