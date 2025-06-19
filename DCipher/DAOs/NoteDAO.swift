//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

protocol NoteDAOProtocol {
    func create(_ note: Note) throws
    func fetchAll() throws -> [Note]
    func delete(_ note: Note) throws
    func update(_ note: Note) throws
}

class NoteDAO: NoteDAOProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func create(_ note: Note) throws {
        context.insert(note)
        try context.save()
    }

    func fetchAll() throws -> [Note] {
        let descriptor = FetchDescriptor<Note>()
        return try context.fetch(descriptor)
    }

    func delete(_ note: Note) throws {
        context.delete(note)
        try context.save()
    }

    func update(_ note: Note) throws {
        try context.save()
    }
}
