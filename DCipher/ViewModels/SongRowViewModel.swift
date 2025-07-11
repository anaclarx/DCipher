//
//  SongRowViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SongRowViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 21/06/25.
//

import Foundation
import SwiftData

struct SongRowViewModel {
    let title: String
    let artist: String
    let goal: String

    init(title: String, artist: String, goal: String) {
        self.title = title
        self.artist = artist
        self.goal = goal
    }

    init(song: Song) {
        self.title = song.title
        self.artist = "\(song.artist)"
        self.goal = "\(song.goal)"
    }
}


