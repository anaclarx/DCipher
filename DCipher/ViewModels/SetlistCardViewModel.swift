//
//  SetlistCardViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SetListCardViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 05/07/25.
//

// SetlistCardViewModel.swift

import Foundation

struct SetlistCardViewModel {
    let title: String
    let songCount: Int
    let setlist: Setlist

    init(setlist: Setlist) {
        self.title = setlist.title
        self.songCount = setlist.songs.count
        self.setlist = setlist
    }
}

