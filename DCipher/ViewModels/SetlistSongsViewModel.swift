//
//  SetlistSongsViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SetlistSongsViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 21/06/25.
//

import Foundation
import SwiftData

@MainActor
class SetlistSongsViewModel: ObservableObject {
    let setlist: Setlist
    private let context: ModelContext

    @Published var songs: [Song] = []

    init(setlist: Setlist, context: ModelContext) {
        self.setlist = setlist
        self.context = context
        self.songs = setlist.songs
    }

    func removeSong(_ song: Song) {
        guard let index = setlist.songs.firstIndex(of: song) else { return }
        setlist.songs.remove(at: index)
        setlist.updatedAt = Date() // alteração na setlist
        songs = setlist.songs

        do {
            try context.save()
        } catch {
            print("Erro ao salvar contexto após remover música: \(error)")
        }
    }
}


