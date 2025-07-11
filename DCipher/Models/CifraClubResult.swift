//
//  CifraClubResult.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  CfraClubSong.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

import Foundation


struct CifraClubResult: Identifiable, Decodable {
    let id = UUID()
    let artist: String
    let name: String
    let youtube_url: String?
    let cifraclub_url: String?
    let cifra: [String]
}

