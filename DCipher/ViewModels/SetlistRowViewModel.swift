//
//  SetlistRowViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SetListRowViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 21/06/25.
//
import Foundation
import SwiftData

struct SetlistRowViewModel {
    let setlist: Setlist

    var title: String {
        setlist.title
    }

    var songCountText: String {
        "\(setlist.songs.count) songs"
    }

    var songs: [Song] {
        setlist.songs
    }

    init(setlist: Setlist) {
        self.setlist = setlist
    }
}
