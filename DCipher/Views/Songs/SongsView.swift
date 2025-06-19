//
//  SongView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI

struct SongsListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Songs")
                .font(.largeTitle)
                .foregroundColor(.appPrimary)
                .padding(.top)
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<5) { _ in
                        SongRowView()
                    }
                }
            }
        }
        .padding()
        .background(Color.appBackground)
    }
}
