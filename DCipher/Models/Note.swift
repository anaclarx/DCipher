//
//  Note.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//
import Foundation
import SwiftData

@Model
final class Note {
    @Attribute(.unique) var id: UUID
    var content: String
    var attachedImage: Data?

    @Relationship(inverse: \Song.notes) var song: Song?

    init(id: UUID = .init(), content: String, attachedImage: Data? = nil, song: Song? = nil) {
        self.id = id
        self.content = content
        self.attachedImage = attachedImage
        self.song = song
    }
}
