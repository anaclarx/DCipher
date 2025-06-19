//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//
import Foundation
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Search")
                .font(.largeTitle)
                .foregroundColor(.appPrimary)

            TextField("Import a new song", text: $searchText)
                .padding(10)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
                .padding(.horizontal)

            Spacer()
            Image(systemName: "music.note.list")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.appPrimary)
            Text("Ready to explore?\nStart a new search and build your musical world!")
                .multilineTextAlignment(.center)
                .foregroundColor(.appBodyText)
            Spacer()
        }
        .background(Color.appBackground)
    }
}
