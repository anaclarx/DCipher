//
//  MockDataSeeder.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  MockDataSeeder.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 05/07/25.
//

// MockDataSeeder.swift

import Foundation
import SwiftData

struct MockDataSeeder {

    static func seedIfNeeded(context: ModelContext) async {
        do {
            let songDAO = SongDAO(context: context)
            let setlistDAO = SetlistDAO(context: context)

            // Evitar duplicação
            let existingSongs = try songDAO.fetchAll()
            if !existingSongs.isEmpty { return }

            // Categorias
            let category1 = Category(name: "Rock")
            let category2 = Category(name: "Pop")
            let category3 = Category(name: "Indie")

            // Usuário
            let user = User(preferences: [category1, category2, category3])
            context.insert(user)

            // Notas
            let note1 = Note(content: "Treinar refrão com mais energia.")
            let note2 = Note(content: "Melhorar dedilhado na introdução.")
            let note3 = Note(content: "Focar no tempo na segunda parte.")

            // Músicas mock
            let song1 = Song(title: "Wonderwall", artist: "Oasis", type: "Original", status: "Completed", goal: "Practice")
            song1.notes = [note1]

            let song2 = Song(title: "Yesterday", artist: "Beatles", type: "Cover", status: "In Progress", goal: "Learn")
            song2.notes = [note2]

            let song3 = Song(title: "Little Things", artist: "Oasis", type: "Original", status: "New", goal: "Master")

            let song4 = Song(title: "My First Song", artist: "Me", type: "Original", status: "Idea", goal: "Compose")
            song4.notes = [note3]

            try songDAO.create(song1)
            try songDAO.create(song2)
            try songDAO.create(song3)
            try songDAO.create(song4)

            // Setlists mock
            let setlist1 = Setlist(title: "Setlist 1", type: "Show")
            setlist1.songs = [song1, song2]

            let setlist2 = Setlist(title: "Setlist 2", type: "Estudo")
            setlist2.songs = [song3, song4]

            try setlistDAO.create(setlist1)
            try setlistDAO.create(setlist2)

            try context.save()

            print("✅ Dados mock populados com sucesso.")

        } catch {
            print("❌ Erro ao popular dados mock: \(error)")
        }
    }
}
