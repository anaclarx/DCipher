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
    
    func fetchAllSongs() -> [Song] {
        guard let dao else { return [] }
        do {
            return try dao.fetchAll()
        } catch {
            print("Error fetching songs: \(error)")
            return []
        }
    }

    
    func refresh() {
        loadAllSongs()
    }


    func addSong(from result: CifraClubResult, imageUrl: String?) -> Bool {
        guard let dao else { return false }

        if dao.exists(title: result.name, artist: result.artist) {
            print("🎵 Música já existe na biblioteca")
            return false
        }

        let song = Song(
            title: result.name,
            artist: result.artist,
            type: "Imported",
            status: "",
            goal: ""
        )
        song.lyrics = result.cifra.joined(separator: "\n")
        song.source = .CIFRA_CLUB
        song.artworkUrl = imageUrl // ✅ salva imagem aqui

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
    
    func convertRecommendationToSong(_ recommendation: ITunesSong) -> Song {
        let song = Song(
            title: recommendation.trackName,
            artist: recommendation.artistName,
            type: "imported",
            status: "new",
            goal: "study"
        )
        song.artworkUrl = recommendation.artworkUrl100 // atribuição direta
        song.source = .CIFRA_CLUB
        return song
    }



    func saveRecommendedSong(_ song: Song) {
        guard let dao else { return }
        if dao.exists(title: song.title, artist: song.artist) {
            print("🎵 Já existe")
            return
        }
        try? dao.create(song)
        loadAllSongs()
    }
}

