//
//  HomeViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 05/07/25.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recentSongs: [Song] = []
    @Published var recentSetlists: [SetlistCardViewModel] = []
    @Published var recommendations: [RecommendationCardViewModel] = [] // Adicionado para corrigir erro

    func loadData(using context: ModelContext) {
        let songDAO = SongDAO(context: context)
        let setlistDAO = SetlistDAO(context: context)

        if let recent = try? songDAO.fetchRecentSongs(limit: 5) {
            self.recentSongs = recent
        }

        if let recent = try? setlistDAO.fetchRecentSetlists(limit: 5) {
            self.recentSetlists = recent.map {
                SetlistCardViewModel(setlist: $0)
            }
        }

        // TODO: Preencher com dados mockados até a API de recomendações estar disponível
        self.recommendations = [
            RecommendationCardViewModel(title: "Exemplo 1", songCount: 3),
            RecommendationCardViewModel(title: "Exemplo 2", songCount: 5)
        ]
    }

    func delete(song: Song, using context: ModelContext) {
        do {
            try SongDAO(context: context).delete(song)
            loadData(using: context)
        } catch {
            print("Erro ao deletar música: \(error)")
        }
    }
}

