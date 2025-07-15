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
    let artworkUrl: String?

    init(title: String, artist: String, goal: String, artworkUrl: String?) {
        self.title = title
        self.artist = artist
        self.goal = goal
        self.artworkUrl = artworkUrl
    }


    init(song: Song) {
        self.title = song.title
        self.artist = song.artist
        self.goal = song.goal ?? ""
        self.artworkUrl = song.artworkUrl?.isEmpty == false ? song.artworkUrl : nil
    }

}


