//
//  ITunesSong.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  ITuneSong.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

struct ITunesSong: Decodable, Identifiable {
    let trackId: Int
    let trackName: String
    let artistName: String
    
    var id: Int { trackId }
}
