//
//  Setlist.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//
import Foundation
import SwiftData
import Swift

@Model
final class Setlist {
    @Attribute(.unique) var id: UUID
    var title: String
    var createdDate: Date
    var type: String
    var updatedAt: Date = Date()

    @Relationship(deleteRule: .nullify) var songs: [Song] = []

    init(id: UUID = .init(), title: String, type: String, createdDate: Date = .now) {
        self.id = id
        self.title = title
        self.type = type
        self.createdDate = createdDate
        self.songs = []
    }
}
