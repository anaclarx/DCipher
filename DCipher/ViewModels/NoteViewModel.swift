//
//  NoteViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Observable
class NoteViewModel {
    private let dao: NoteDAOProtocol

    var notes: [Note] = []

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

    func addNote(_ note: Note) {
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
}

