//
//  OnboardingViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//


import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var selectedGenres: [String] = []
    @Published var hasSeenOnboarding: Bool = false

    func toggleGenre(_ genre: String) {
        if selectedGenres.contains(genre) {
            selectedGenres.removeAll { $0 == genre }
        } else if selectedGenres.count < 5 {
            selectedGenres.append(genre)
        }
    }

    func saveGenresAndFinish() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.hasSeenOnboarding)

        if let encoded = try? JSONEncoder().encode(selectedGenres) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.userGenres)
        }
    }

}
