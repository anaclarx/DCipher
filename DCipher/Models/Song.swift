//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Model
final class Song {
    @Attribute(.unique) var id: UUID
    var title: String
    var artist: String
    var type: String
    var status: String
    var goal: String

    @Relationship var notes: [Note]

    @Relationship(inverse: \Setlist.songs) var setlist: Setlist?
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
}
