//
//  OriginalSong.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Model
final class OriginalSong {
    var lyrics: String

    init(lyrics: String) {
        self.lyrics = lyrics
    }
}
