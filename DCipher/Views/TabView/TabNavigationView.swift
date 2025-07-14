//
//  TabNavigationView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI
import SwiftData

struct TabNavigationView: View {
    @State private var selectedTab: TabItem = .menu
    @Environment(\.modelContext) private var modelContext
    @State private var hasSeeded = false
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.appBackgroundComponents)
    }
    
    var body: some View {
        HStack{
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
}
