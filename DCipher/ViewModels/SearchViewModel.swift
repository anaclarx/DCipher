//
//  SearchViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SearchViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//
import Foundation
import SwiftData
import SwiftUI


@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchResults: [ITunesSong] = []
    @Published var chordResult: String? = nil
    @Published var isLoadingITunes = false
    @Published var isLoadingCifra = false
    @Published var error: String? = nil
    @Published var progress: Double = 0
    @Published var totalAttempts: Int = 0


    private var verifiedURLCache: Set<String> = []

    func searchSongs(term: String) {
        guard let query = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://itunes.apple.com/search?term=\(query)&entity=song")
        else {
            error = "Termo inválido."
            return
        }

        isLoadingITunes = true
        error = nil
        chordResult = nil
        searchResults = []

        URLSession.shared.dataTask(with: url) { data, _, err in
            DispatchQueue.main.async {
                self.isLoadingITunes = false
            }

            if let err = err {
                DispatchQueue.main.async {
                    self.error = err.localizedDescription
                }
                return
            }

            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = result.results
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = "Erro ao decodificar resultados"
                }
            }
        }.resume()
    }

    func fetchChordResult(for song: String, artist: String) async -> CifraClubResult? {
        await MainActor.run {
            self.isLoadingCifra = true
            self.error = nil
            self.progress = 0
        }

        let apiBaseURL = "http://localhost:3000"
        let artistSlugs = generateArtistSlugVariations(from: artist, song: song)

        await MainActor.run {
            self.totalAttempts = artistSlugs.count
        }

        for (index, (artistSlug, songSlug)) in artistSlugs.enumerated() {
            let apiURLString = "\(apiBaseURL)/artists/\(artistSlug)/songs/\(songSlug)"
            guard let apiURL = URL(string: apiURLString) else { continue }

            print("🎸 Tentando cifra via API: \(apiURLString)")

            do {
                let (data, _) = try await URLSession.shared.data(from: apiURL)
                let result = try JSONDecoder().decode(CifraClubResult.self, from: data)

                // ⚠️ Verifica se o array de cifras está vazio
                if result.cifra.isEmpty {
                    continue
                }

                await MainActor.run {
                    self.isLoadingCifra = false
                    self.progress = 1
                }
                return result
            } catch {
                print("❌ Erro ao decodificar ou carregar cifra: \(error.localizedDescription)")
            }

            await MainActor.run {
                withAnimation(.linear(duration: 0.2)) {
                    self.progress = Double(index + 1) / Double(max(1, artistSlugs.count))
                }
            }
        }

        await MainActor.run {
            self.error = "Unfortunately, this music is still not available to download. Try with another one."
            self.isLoadingCifra = false
            self.progress = 1
        }

        return nil
    }

    private func generateArtistSlugVariations(from artist: String, song: String) -> [(String, String)] {
        let folding = artist.folding(options: .diacriticInsensitive, locale: .current)
            .replacingOccurrences(of: "\\([^\\)]*\\)", with: "", options: .regularExpression)
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let noSymbols = folding.replacingOccurrences(of: "[’'.,]", with: "", options: .regularExpression)

        let parts = noSymbols.components(separatedBy: CharacterSet(charactersIn: ",&"))

        let first = parts.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let rest = parts.dropFirst().map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        var variations: [(String, String)] = []

        let slugBase = slugify(first)
        let slugSong = slugify(song)

        if rest.isEmpty {
            variations.append((slugBase, slugSong))
        } else {
            let restSlug = rest.map { slugify($0) }.joined(separator: "-")

            let candidates: [(String, String)] = [
                ("\(slugBase)-\(restSlug)", slugSong),
                ("\(slugBase)-e-\(restSlug)", slugSong),
                (slugBase, "\(slugSong)-feat-\(restSlug)"),
                (slugBase, "\(slugSong)-part-\(restSlug)"),
                ("\(restSlug)-\(slugBase)", slugSong),
                ("\(restSlug)-e-\(slugBase)", slugSong),
                (restSlug, "\(slugSong)-feat-\(slugBase)"),
                (restSlug, "\(slugSong)-part-\(slugBase)")
            ]

            for candidate in candidates where !variations.contains(where: { $0 == candidate }) {
                variations.append(candidate)
            }
        }

        return variations
    }


    private func slugify(_ text: String) -> String {
        let folding = text.folding(options: .diacriticInsensitive, locale: .current)

        let noParenthesis = folding.replacingOccurrences(of: "\\([^\\)]*\\)", with: "", options: .regularExpression)

        let cleaned = noParenthesis
            .lowercased()
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "&", with: "")
            .replacingOccurrences(of: "[’'.,]", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: "-", options: .regularExpression)
            .replacingOccurrences(of: "-{2,}", with: "-", options: .regularExpression)

        return cleaned.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
    }

    func clear() {
        searchResults = []
        chordResult = nil
        error = nil
        isLoadingITunes = false
        isLoadingCifra = false
    }

    private struct SearchResult: Decodable {
        let results: [ITunesSong]
    }
}
