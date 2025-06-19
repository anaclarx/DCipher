//
//  Category.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Model
final class Category {
    var name: String

    init(name: String) {
        self.name = name
    }
}
