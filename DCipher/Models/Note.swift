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

    init(id: UUID = .init(), content: String, attachedImage: Data? = nil) {
        self.id = id
        self.content = content
        self.attachedImage = attachedImage
    }
}
