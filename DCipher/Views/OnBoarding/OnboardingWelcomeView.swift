//
//  Untitled.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Text("Welcome to your musical workspace")
                    .font(.fliegeMonoMedium(size: 22))
                    .foregroundColor(.appTitleText)
                    .multilineTextAlignment(.center)

                Image(systemName: "doc.text.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.appPrimary)

                Text("Create, organize, and rehearse your songs – all in one place.")
                    .font(.fliegeMonoMedium(size: 16))
                    .foregroundColor(.appBodyText)
                    .multilineTextAlignment(.center)

                Spacer()

                NavigationLink("Let's Start", destination: OnboardingGenresView())
                    .buttonStyle(.borderedProminent)
                    .tint(.appPrimary)
                    .font(.fliegeMonoMedium(size: 18))
            }
            .padding()
            .background(Color.appBackground.ignoresSafeArea())
            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    NavigationLink("Skip", destination: TabNavigationView())
//                }
            }
        }
    }
}

