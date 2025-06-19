//
//  HomeView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Your Recommendations")
                    .font(.title2)
                    .foregroundColor(.appBodyText)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<3) { _ in
                            RecommendationCardView()
                        }
                    }
                    .padding(.horizontal)
                }

                Text("Recent Setlists")
                    .font(.title2)
                    .foregroundColor(.appBodyText)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<3) { _ in
                            SetlistCardView()
                        }
                    }
                    .padding(.horizontal)
                }

                Text("Recent Songs")
                    .font(.title2)
                    .foregroundColor(.appBodyText)

                VStack(spacing: 8) {
                    ForEach(0..<5) { _ in
                        SongRowView()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .background(Color.appBackground)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}
