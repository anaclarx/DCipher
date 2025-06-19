//
//  SongDAo.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

protocol SongDAOProtocol {
    func create(_ song: Song) throws
    func fetchAll() throws -> [Song]
    func delete(_ song: Song) throws
    func update(_ song: Song) throws
    func get(byId id: UUID) throws -> Song?
    func search(byTitle title: String) throws -> [Song]
    func search(byGoal goal: String) throws -> [Song]
    func search(byType type: String) throws -> [Song]
}

class SongDAO: SongDAOProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func create(_ song: Song) throws {
        context.insert(song)
        try context.save()
    }

    func fetchAll() throws -> [Song] {
        let descriptor = FetchDescriptor<Song>()
        return try context.fetch(descriptor)
    }

    func delete(_ song: Song) throws {
        context.delete(song)
        try context.save()
    }

    func update(_ song: Song) throws {
        try context.save()
    }

    func get(byId id: UUID) throws -> Song? {
        let predicate = #Predicate<Song> { $0.id == id }
        let descriptor = FetchDescriptor<Song>(predicate: predicate)
        return try context.fetch(descriptor).first
    }

    func search(byTitle title: String) throws -> [Song] {
        let predicate = #Predicate<Song> { $0.title.localizedStandardContains(title) }
        let descriptor = FetchDescriptor<Song>(predicate: predicate)
        return try context.fetch(descriptor)
    }

    func search(byGoal goal: String) throws -> [Song] {
        let predicate = #Predicate<Song> { $0.goal == goal }
        let descriptor = FetchDescriptor<Song>(predicate: predicate)
        return try context.fetch(descriptor)
    }

    func search(byType type: String) throws -> [Song] {
        let predicate = #Predicate<Song> { $0.type == type }
        let descriptor = FetchDescriptor<Song>(predicate: predicate)
        return try context.fetch(descriptor)
    }
}
