//
//  User.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//
//

import Foundation
import SwiftData

@Model
final class User {
    var preferences: [Category]

    init(preferences: [Category] = []) {
        self.preferences = preferences
    }
}
