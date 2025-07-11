//
//  HomeViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  HomeViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 05/07/25.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties

    @Published var recentSongs: [SongRowViewModel] = []
    @Published var recentSetlists: [SetlistCardViewModel] = []
    @Published var recommendations: [RecommendationCardViewModel] = []

    // MARK: - Init

    init() {
        loadDummyData()
    }

    // MARK: - Load Dummy (or real) data

    private func loadDummyData() {
        // Músicas recentes
        recentSongs = [
            SongRowViewModel(title: "Wonderwall", artist: "Oasis", goal: "Practice"),
            SongRowViewModel(title: "Yesterday", artist: "Beatles", goal: "Learn"),
            SongRowViewModel(title: "Little Things", artist: "Oasis", goal: "Master"),
            SongRowViewModel(title: "My First Songs", artist: "Me", goal: "Compose"),
            SongRowViewModel(title: "Love’s Train", artist: "Unknown", goal: "Play")
        ]

        // Setlists recentes
        recentSetlists = [
            SetlistCardViewModel(title: "Setlist 1", songCount: 12),
            SetlistCardViewModel(title: "Setlist 2", songCount: 8)
        ]

        // Recomendações
        recommendations = [
            RecommendationCardViewModel(title: "Your style", songCount: 12)
        ]
    }
}
