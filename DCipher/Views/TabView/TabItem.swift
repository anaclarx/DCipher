//
//  TabItem.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI

enum TabItem: Hashable {
    case menu, search, setlists, songs

    var label: some View {
        switch self {
        case .menu:
            return Label("Menu", systemImage: "house")
        case .search:
            return Label("Search", systemImage: "magnifyingglass")
        case .setlists:
            return Label("Setlists", systemImage: "list.bullet")
        case .songs:
            return Label("Songs", systemImage: "music.note")
        }
    }
}
