//
//  SongViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Observable
class SongViewModel {
    private let dao: SongDAOProtocol

    var songs: [Song] = []

    init(context: ModelContext) {
        self.dao = SongDAO(context: context)
        loadAllSongs()
    }

    func loadAllSongs() {
        do {
            songs = try dao.fetchAll()
        } catch {
            print("Error fetching songs: \(error)")
        }
    }

    func addSong(_ song: Song) {
        do {
            try dao.create(song)
            loadAllSongs()
        } catch {
            print("Error creating song: \(error)")
        }
    }

    func deleteSong(_ song: Song) {
        do {
            try dao.delete(song)
            loadAllSongs()
        } catch {
            print("Error deleting song: \(error)")
        }
    }

    func search(byTitle title: String) {
        do {
            songs = try dao.search(byTitle: title)
        } catch {
            print("Search error: \(error)")
        }
    }

    func search(byGoal goal: String) {
        do {
            songs = try dao.search(byGoal: goal)
        } catch {
            print("Search error: \(error)")
        }
    }

    func search(byType type: String) {
        do {
            songs = try dao.search(byType: type)
        } catch {
            print("Search error: \(error)")
        }
    }
}
