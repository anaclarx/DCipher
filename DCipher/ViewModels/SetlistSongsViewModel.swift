//
//  SetlistSongsViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SetlistSongsViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 21/06/25.
//

import Foundation
import SwiftData

@Observable
class SetlistSongsViewModel {
    let setlist: Setlist
    var songs: [Song] {
        setlist.songs
    }

    init(setlist: Setlist) {
        self.setlist = setlist
    }
}
