//
//  SetlistViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData


class SetlistViewModel: ObservableObject {
    private var context: ModelContext?
    @Published var setlists: [Setlist] = []

    init(context: ModelContext?) {
        self.context = context
        fetchSetlists()
    }

    func updateContext(_ newContext: ModelContext) {
        self.context = newContext
        fetchSetlists()
    }

    func fetchSetlists() {
        guard let context = context else { return }
        do {
            let descriptor = FetchDescriptor<Setlist>(sortBy: [SortDescriptor(\.title)])
            setlists = try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar setlists: \(error)")
        }
    }

    func addSetlist(_ setlist: Setlist) {
        context?.insert(setlist)
        fetchSetlists()
    }

    func deleteSetlist(_ setlist: Setlist) {
        context?.delete(setlist)
        fetchSetlists()
    }
    
}

