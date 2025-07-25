//
//  SetlistDAO.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

protocol SetlistDAOProtocol {
    func create(_ setlist: Setlist) throws
    func fetchAll() throws -> [Setlist]
    func delete(_ setlist: Setlist) throws
    func update(_ setlist: Setlist) throws
}

class SetlistDAO: SetlistDAOProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func create(_ setlist: Setlist) throws {
        context.insert(setlist)
        try context.save()
    }
    
    func fetchRecentSetlists(limit: Int = 5) throws -> [Setlist] {
        let descriptor = FetchDescriptor<Setlist>(
            sortBy: [SortDescriptor(\.updatedAt, order: .reverse)]
        )
        return try context.fetch(descriptor).prefix(limit).map { $0 }
    }


    func fetchAll() throws -> [Setlist] {
        let descriptor = FetchDescriptor<Setlist>()
        return try context.fetch(descriptor)
    }

    func delete(_ setlist: Setlist) throws {
        context.delete(setlist)
        try context.save()
    }

    func update(_ setlist: Setlist) throws {
        setlist.updatedAt = Date()
        try context.save()
    }
}
