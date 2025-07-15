//
//  RecommendationViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 14/07/25.
//
import Foundation
import Swift

class RecommendationViewModel: ObservableObject, Identifiable {
    let song: ITunesSong
    var id: Int { song.id }

    init(song: ITunesSong) {
        self.song = song
    }
}
