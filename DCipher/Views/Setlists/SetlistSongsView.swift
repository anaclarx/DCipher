//
//  SetlistSongsView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 19/06/25.
//

import SwiftUI

struct SetlistSongsView: View {
    @State var viewModel: SetlistSongsViewModel
    @State var songViewModel: SongRowViewModel?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(viewModel.setlist.title)
                    .font(.largeTitle)
                    .foregroundColor(.appPrimary)

                Spacer()
            }
            .padding(.top)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.songs, id: \.id) { song in
                        SongRowView(viewModel: SongRowViewModel(song: song))
                    }
                }
            }
        }
        .padding()
        .background(Color.appBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
