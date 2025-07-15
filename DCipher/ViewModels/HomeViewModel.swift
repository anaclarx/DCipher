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
    @Published var recommendations: [RecommendationViewModel] = [] 

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
        fetchRecommendations()
    }


    func delete(song: Song, using context: ModelContext) {
        do {
            try SongDAO(context: context).delete(song)
            loadData(using: context)
        } catch {
            print("Erro ao deletar música: \(error)")
        }
    }
    func removeRecommendation(_ song: ITunesSong) {
        recommendations.removeAll {
            $0.song.trackId == song.trackId
        }
    }
    func getUserGenres() -> [String] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.userGenres),
              let genres = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        print(UserDefaults.standard.dictionaryRepresentation().keys)
        return genres
    }

    func fetchRecommendations() {
        var genres = getUserGenres()
            .map { $0.lowercased().replacingOccurrences(of: " ", with: "+") } // normaliza
        print("Generos aqui: \(genres)")

        guard !genres.isEmpty else { return }

        while genres.count < 5 {
            if let random = genres.randomElement() {
                genres.append(random)
            }
        }

        genres = Array(genres.prefix(5)) // garante 5 gêneros

        Task {
            var fetched: [ITunesSong] = []

            for genre in genres {
                if let song = await fetchOneSong(for: genre) {
                    fetched.append(song)
                }
            }

            await MainActor.run {
                self.recommendations = fetched.map { RecommendationViewModel(song: $0) }
            }
        }
    }

    func fetchOneSong(for genre: String) async -> ITunesSong? {
        let genreQueryTerms: [String: String] = [
            "pop": "pop+music",
            "rock": "rock+music",
            "indie": "indie+music",
            "folk": "folk+music",
            "blues": "blues+music",
            "jazz": "jazz+music",
            "acoustic": "acoustic+music",
            "country": "country+music",
            "reggae": "reggae+music",
            "r&b": "r+b+music",
            "soul": "soul+music",
            "gospel": "gospel+music"
        ]

        let query = genreQueryTerms[genre] ?? "\(genre)+music"
        let term = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? genre

        guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)&entity=song&limit=10") else {
            return nil
        }

        print("Buscando com URL: \(url)")

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(SearchResult.self, from: data)
            return result.results.randomElement()
        } catch {
            print("Erro ao buscar música para gênero \(genre): \(error)")
            return nil
        }
    }



    private struct SearchResult: Decodable {
        let results: [ITunesSong]
    }



}

