//
//  SwiftDataContainer.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  SwiftDataContainer.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//

import SwiftData

final class SwiftDataContainer {
    static let shared = SwiftDataContainer()
    
    let container: ModelContainer

    private init() {
        do {
            container = try ModelContainer(for: Song.self) // adicione outros models se necessário
        } catch {
            fatalError("Erro ao criar o ModelContainer: \(error)")
        }
    }
}
