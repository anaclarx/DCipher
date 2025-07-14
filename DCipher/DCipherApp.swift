//
//  DCipherApp.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI
import SwiftData

@main
struct DCipherApp: App {
    @AppStorage(UserDefaultsKeys.hasSeenOnboarding) var hasSeenOnboarding: Bool = false

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Song.self,
            Setlist.self,
            Note.self,
//            Category.self,
//            User.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                TabNavigationView()
            } else {
                OnboardingWelcomeView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
