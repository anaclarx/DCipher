//
//  Item.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
