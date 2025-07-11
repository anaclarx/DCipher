//
//  CifraClubService.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  CifraClubService.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

import Foundation

class CifraClubService {
    static let shared = CifraClubService()
    private let baseURL = "http://192.168.0.41:3000"

    func fetchSong(artist: String, song: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "\(baseURL)/artists/\(artist)/songs/\(song)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let request = URLRequest(url: url, timeoutInterval: 120) // ✅ tempo personalizado

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                return completion(.failure(URLError(.cannotParseResponse)))
            }

            completion(.success(responseString))
        }.resume()
    }
}
