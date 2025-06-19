//
//  TabNavigationView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI

struct TabNavigationView: View {
    @State private var selectedTab: TabItem = .menu

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem { TabItem.menu.label }
                .tag(TabItem.menu)

            SearchView()
                .tabItem { TabItem.search.label }
                .tag(TabItem.search)

            SetlistsListView()
                .tabItem { TabItem.setlists.label }
                .tag(TabItem.setlists)

            SongsListView()
                .tabItem { TabItem.songs.label }
                .tag(TabItem.songs)
        }
        .tint(.appPrimary)
    }
}
