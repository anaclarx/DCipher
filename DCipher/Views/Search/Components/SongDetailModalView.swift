//
//  SongDetailModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SongModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

//
//  SongModalView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

import SwiftUI

struct SongDetailModalView: View {
    let song: CifraClubResult
    let onAdd: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(song.name)
                .font(.title2.bold())
                .foregroundColor(.appPrimary)

            Text("by \(song.artist)")
                .font(.subheadline)
                .foregroundColor(.appBodyText)

            if let youtube = song.youtube_url {
                Link("Watch on Youtube", destination: URL(string: youtube)!)
                    .font(.footnote)
                    .foregroundColor(.blue)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(song.cifra.indices, id: \.self) { index in
                        let line = song.cifra[index]
                        Text(line)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.appBodyText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

            Spacer()

            Button(action: onAdd) {
                Text("Add Music")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.appBackground)
        .presentationDetents([.fraction(0.9)])
    }
}
