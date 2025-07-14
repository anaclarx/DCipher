//
//  NoteColor.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 13/07/25.
//
import Foundation
import SwiftUI

enum NoteColor: String {
    case yellow, blue, pink

    var color: Color {
        switch self {
        case .yellow: return .yellow
        case .blue: return .blue
        case .pink: return .pink
        }
    }
}
