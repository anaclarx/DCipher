//
//  HomeView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Your Recommendations")
                        .font(.fliegeMonoRegular(size: 20))
                        .foregroundColor(.appBodyText)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.recommendations.indices, id: \.self) { index in
                                RecommendationCardView(viewModel: viewModel.recommendations[index])
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Recent Setlists")
                        .font(.fliegeMonoRegular(size: 20))
                        .foregroundColor(.appBodyText)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.recentSetlists.indices, id: \.self) { index in
                                SetlistCardView(viewModel: viewModel.recentSetlists[index])
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Recent Songs")
                        .font(.fliegeMonoRegular(size: 20))
                        .foregroundColor(.appBodyText)
                        .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        ForEach(viewModel.recentSongs.indices, id: \.self) { index in
                            SongRowView(viewModel: viewModel.recentSongs[index])
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.fliegeMonoMedium(size: 32))
                        .foregroundColor(.appPrimary)
                }
            }
            .toolbarBackground(Color.appBackgroundComponents, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .padding(.bottom, 2)
            .background(Color.appBackground)
        }
    }
}
