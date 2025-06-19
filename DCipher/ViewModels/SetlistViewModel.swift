//
//  SetlistViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Observable
class SetlistViewModel {
    private let dao: SetlistDAOProtocol

    var setlists: [Setlist] = []

    init(context: ModelContext) {
        self.dao = SetlistDAO(context: context)
        loadAllSetlists()
    }

    func loadAllSetlists() {
        do {
            setlists = try dao.fetchAll()
        } catch {
            print("Error fetching setlists: \(error)")
        }
    }

    func addSetlist(_ setlist: Setlist) {
        do {
            try dao.create(setlist)
            loadAllSetlists()
        } catch {
            print("Error creating setlist: \(error)")
        }
    }

    func deleteSetlist(_ setlist: Setlist) {
        do {
            try dao.delete(setlist)
            loadAllSetlists()
        } catch {
            print("Error deleting setlist: \(error)")
        }
    }
}
