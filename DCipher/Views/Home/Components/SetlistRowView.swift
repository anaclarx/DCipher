//
//  SetlistRowView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftUI


struct SetlistRowView: View {
    let setlist: Setlist
    @ObservedObject var viewModel: SetlistViewModel
    @Environment(\.modelContext) private var context
    @State private var showDeleteAlert = false
    
    var body: some View {
        HStack {
            NavigationLink(destination: SetlistSongsView(viewModel: SetlistSongsViewModel(setlist: setlist, context: context))) {
                HStack(spacing: 16) {
                    Image(systemName: "music.note")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.appAccent)
                    VStack(alignment: .leading) {
                        Text(setlist.title)
                            .font(.fliegeMonoMedium(size: 16))
                            .foregroundColor(.appTitleText)
                        Text("\(setlist.songs.count) song(s)")
                            .font(.subheadline)
                            .foregroundColor(.appPrimary)
                        Text(setlist.type)
                            .font(.fliegeMonoRegular(size: 12))
                            .foregroundColor(.appBodyText)

                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            Menu {
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Label("Delete Setlist", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.appBodyText)
                    .padding()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.appBorder, lineWidth: 1)
        )
        .alert("Delete Setlist?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.deleteSetlist(setlist)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this setlist? The songs inside will not be deleted.")
        }
    }
}
