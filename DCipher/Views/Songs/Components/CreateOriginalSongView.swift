//
//  CreateOriginalSongView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  CreateOriginalSongView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 08/07/25.
//

import SwiftUI

struct CreateOriginalSongView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var artist: String = ""
    @State private var goal: String = ""
    @State private var lyrics: String = ""

    let viewModel: SongViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("New Song")
                    .font(.fliegeMonoMedium(size: 28))
                    .foregroundColor(.appPrimary)

                Group {
                    TextField("Title", text: $title)
                    TextField("Artist", text: $artist)
                    TextField("Goal", text: $goal)

                    Text("Music Sheet")
                        .font(.fliegeMonoRegular(size: 18))
                        .foregroundColor(.appBodyText)

                    TextEditor(text: $lyrics)
                        .frame(minHeight: 200)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.appBodyText)
                        .background(Color.appBackgroundComponents)
                }
                .textFieldStyle(.roundedBorder)
                .font(.fliegeMonoRegular(size: 16))
                .foregroundColor(.appBodyText)

                Button(action: {
                    let song = Song(
                        title: title,
                        artist: artist,
                        type: "original",
                        status: "not_started",
                        goal: goal
                    )
                    song.lyrics = lyrics
                    song.source = SourceEnum.ORIGINAL
                    viewModel.addOriginalSong(song)
                    dismiss()
                }) {
                    Text("Save Song")
                         .font(.fliegeMonoRegular(size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.appPrimary)
                        .cornerRadius(12)
                }
                .disabled(title.isEmpty || lyrics.isEmpty)
                .opacity((title.isEmpty || lyrics.isEmpty) ? 0.6 : 1)

                Spacer()
            }
            .padding()
        }
        .background(Color.appBackground)
    }
}
