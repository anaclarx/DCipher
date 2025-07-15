//
//  NoteEditorView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 13/07/25.
//


import SwiftUI


struct NoteEditorView: View {
    var note: Note? // ← nil = novo, não-persistido
    var onSave: (Note) -> Void
    var onDelete: () -> Void
    var song: Song

    @State private var editedContent: String = ""
    @State private var selectedColor: String = "yellow"
    @State private var targetText: String = ""

    let availableColors = ["yellow", "green", "blue", "red", "orange"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Label")) {
                    TextField("Note Label", text: $targetText)
                        .onChange(of: targetText) { newValue in
                            if newValue.count > 10 {
                                targetText = String(newValue.prefix(10))
                            }
                        }
                }

                Section(header: Text("Note")) {
                    TextEditor(text: $editedContent)
                        .frame(minHeight: 100)
                }

                Section(header: Text("Color")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(availableColors, id: \.self) { color in
                                Circle()
                                    .fill(Color.fromString(color))
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: selectedColor == color ? 2 : 0)
                                    )
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }

            .navigationTitle(note == nil ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmedText = editedContent.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedTarget = targetText.trimmingCharacters(in: .whitespacesAndNewlines)

                        let updatedNote = Note(
                            content: trimmedText,
                            targetText: trimmedTarget,
                            color: selectedColor,
                            song: song
                        )

                        onSave(updatedNote)
                    }
                    .disabled(
                        editedContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        targetText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }

                if note != nil {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Delete", role: .destructive) {
                            onDelete()
                        }
                    }
                }
            }
            .onAppear {
                self.editedContent = note?.content ?? ""
                self.targetText = note?.targetText ?? ""
                self.selectedColor = note?.color ?? "yellow"
            }
        }
    }
}

