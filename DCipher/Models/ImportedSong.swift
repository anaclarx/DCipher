//
//  ImportedSong.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//
import Foundation
import SwiftData

@Model
final class ImportedSong {
    var source: String
    var snippetAudio: Data?

    init(source: String, snippetAudio: Data? = nil) {
        self.source = source
        self.snippetAudio = snippetAudio
    }
}
