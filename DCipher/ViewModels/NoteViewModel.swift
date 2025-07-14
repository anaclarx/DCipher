//
//  NoteViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData
import SwiftUI

struct LyricSegment: Identifiable {
    let id = UUID()
    let text: String
    let note: Note?
}

@Observable
class NoteViewModel {
    private let dao: NoteDAOProtocol

    var notes: [Note] = []
    var segments: [LyricSegment] = []

    init(context: ModelContext) {
        self.dao = NoteDAO(context: context)
        loadAllNotes()
    }

    func loadAllNotes() {
        do {
            notes = try dao.fetchAll()
        } catch {
            print("Error fetching notes: \(error)")
        }
    }

    func addNote(content: String, targetText: String, color: String, for song: Song) {
        let note = Note(content: content, targetText: targetText, color: color, song: song)
        do {
            try dao.create(note)
            loadAllNotes()
        } catch {
            print("Error creating note: \(error)")
        }
    }

    func deleteNote(_ note: Note) {
        do {
            try dao.delete(note)
            loadAllNotes()
        } catch {
            print("Error deleting note: \(error)")
        }
    }

    func generateSegments(from lyrics: String) {
        var result: [LyricSegment] = []
        var remaining = lyrics

        for note in notes {
            guard let target = note.targetText,
                  let range = remaining.range(of: target) else { continue }


            let before = String(remaining[..<range.lowerBound])
            let matched = String(remaining[range])
            remaining = String(remaining[range.upperBound...])

            if !before.isEmpty {
                result.append(.init(text: before, note: nil))
            }

            result.append(.init(text: matched, note: note))
        }

        if !remaining.isEmpty {
            result.append(.init(text: remaining, note: nil))
        }

        self.segments = result
    }
}


