//
//  OnboardingGenresView.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI

struct OnboardingGenresView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State private var shouldNavigateToMenu = false

    let allGenres = ["Pop", "Rock", "Indie", "Folk", "Blues", "Jazz", "Acoustic", "Country", "Reggae", "R&B", "Soul", "Gospel"]

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                .font(.fliegeMonoMedium(size: 16))
                .padding(.trailing)
            }

            Text("Your music, your way")
                .font(.fliegeMonoMedium(size: 22))
                .fontWeight(.bold)
                .foregroundColor(.appTitleText)

            Text("Tell us your favorite music genres to receive tailored song suggestions!\nChoose at least one and max of 5")
                .multilineTextAlignment(.center)
                .font(.fliegeMonoMedium(size: 16))
                .foregroundColor(.appBodyText)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 12)], spacing: 12) {
                ForEach(allGenres, id: \.self) { genre in
                    Button(action: {
                        viewModel.toggleGenre(genre)
                    }) {
                        Text(genre)
                            .font(.fliegeMonoMedium(size: 16))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(viewModel.selectedGenres.contains(genre) ? .appBackgroundComponents : .appBodyText)
                            .background(viewModel.selectedGenres.contains(genre) ? Color.appPrimary : .clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.appBorder, lineWidth: 1)
                            )
                            .cornerRadius(12)
                    }
                }
            }

            Button("Finish") {
                viewModel.saveGenresAndFinish()
                shouldNavigateToMenu = true
            }
            .disabled(viewModel.selectedGenres.isEmpty)
            .buttonStyle(.borderedProminent)
            .tint(.appPrimary)
            .font(.fliegeMonoMedium(size: 18))

            Spacer()
        }
        .padding()
        .background(Color.appBackground)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $shouldNavigateToMenu) {
            TabNavigationView()
        }
    }
}

