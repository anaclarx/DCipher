//
//  SavedSongDetailViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SavedSongDetailViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//


import Foundation
import SwiftData

@MainActor
class SavedSongDetailViewModel: ObservableObject {
    @Published var song: Song
    @Published var lyricsText: String
    @Published var notes: [Note] = []
    @Published var selectedNote: Note?
    @Published var showNoteEditor = false

    private let context: ModelContext

    init(song: Song, context: ModelContext) {
        self.song = song
        self.context = context
        self.lyricsText = song.lyrics ?? ""
        loadNotes()
    }

    func loadNotes() {
        do {
            let songId = song.id
            let descriptor = FetchDescriptor<Note>(
                predicate: #Predicate<Note> {
                    $0.song?.id == songId
                }
            )
            notes = try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar notas: \(error)")
        }
    }

    func createNote(_ newNote: Note) {
        newNote.song = song
        song.updatedAt = Date()
        context.insert(newNote)
        try? context.save()
        loadNotes()
    }

    func updateNote(_ existingNote: Note, with updatedNote: Note) {
        existingNote.content = updatedNote.content
        existingNote.targetText = updatedNote.targetText
        existingNote.color = updatedNote.color
        song.updatedAt = Date()
        try? context.save()
        loadNotes()
    }

    func deleteNote(_ note: Note) {
        context.delete(note)
        song.updatedAt = Date()
        try? context.save()
        loadNotes()
    }

    func saveLyrics() {
        song.lyrics = lyricsText
        song.updatedAt = Date()
        do {
            try context.save()
        } catch {
            print("Erro ao salvar lyrics: \(error.localizedDescription)")
        }
    }
}

