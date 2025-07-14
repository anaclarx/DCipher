//
//  SongViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@MainActor
class SongViewModel: ObservableObject {
    private var dao: SongDAOProtocol?

    @Published var songs: [Song] = []
    var isConfigured: Bool {
        dao != nil
    }

    init() {}

    func configure(with context: ModelContext) {
        self.dao = SongDAO(context: context)
        loadAllSongs()
    }

    func loadAllSongs() {
        guard let dao else { return }
        do {
            songs = try dao.fetchAll()
        } catch {
            print("Error fetching songs: \(error)")
        }
    }

    func addSong(from result: CifraClubResult) -> Bool {
        guard let dao else { return false }

        if dao.exists(title: result.name, artist: result.artist) {
            print("🎵 Música já existe na biblioteca")
            return false
        }

        let song = Song(
            title: result.name,
            artist: result.artist,
            type: "imported",
            status: "new",
            goal: "study"
        )
        song.lyrics = result.cifra.joined(separator: "\n")
        song.source = .CIFRA_CLUB

        do {
            try dao.create(song)
            loadAllSongs()
            return true
        } catch {
            print("Error creating song: \(error)")
            return false
        }
    }


    func addOriginalSong(_ song: Song) {
        guard let dao else { return }
        do {
            try dao.create(song)
            loadAllSongs()
        } catch {
            print("Error creating original song: \(error)")
        }
    }

    func deleteSong(_ song: Song) {
        guard let dao else { return }
        do {
            try dao.delete(song)
            loadAllSongs()
        } catch {
            print("Error deleting song: \(error)")
        }
    }

    func search(byTitle title: String) {
        guard let dao else { return }
        do {
            songs = try dao.search(byTitle: title)
        } catch {
            print("Search error: \(error)")
        }
    }
}

