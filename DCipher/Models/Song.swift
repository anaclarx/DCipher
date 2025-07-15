//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData
import Swift 

@Model
final class Song: Hashable, Equatable {
    @Attribute(.unique) var id: UUID
    var title: String
    var artist: String
    var type: String
    var status: String
    var goal: String
    var updatedAt: Date = Date()
    var artworkUrl: String?
    var itunesID: Int?

    @Relationship var notes: [Note]
    
    @Relationship(deleteRule: .nullify) var setlists: [Setlist] = []
    var lyrics: String?
    var source: SourceEnum?

    init(id: UUID = .init(), title: String, artist: String, type: String, status: String, goal: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.type = type
        self.status = status
        self.goal = goal
        self.notes = []
    }

    static func == (lhs: Song, rhs: Song) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
