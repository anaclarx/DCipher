//
//  SavedSongDetailViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SavedSongDetailViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//


import Foundation
import SwiftData

@MainActor
class SavedSongDetailViewModel: ObservableObject {
    @Published var song: Song
    @Published var lyricsText: String

    private let context: ModelContext

    init(song: Song, context: ModelContext) {
        self.song = song
        self.context = context
        self.lyricsText = song.lyrics ?? ""
    }

    func saveLyrics() {
        song.lyrics = lyricsText
        do {
            try context.save()
        } catch {
            print("Erro ao salvar lyrics: \(error.localizedDescription)")
        }
    }
}

