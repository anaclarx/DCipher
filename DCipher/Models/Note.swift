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
    var content: String?
    var targetText: String?
    var color: String?

    @Relationship var song: Song?

    init(content: String?, targetText: String?, color: String?, song: Song?) {
        self.content = content
        self.targetText = targetText
        self.color = color
        self.song = song
    }
}



