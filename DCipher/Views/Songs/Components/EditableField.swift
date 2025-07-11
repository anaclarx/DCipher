//
//  EditableField.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/07/25.
//


//
//  EditableField.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 09/07/25.
//
import Foundation
import SwiftUI

public struct EditableField: View {
    let label: String
    @Binding var text: String

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.fliegeMonoRegular(size: 14))
                .foregroundColor(.appBodyText)
            TextField("Enter \(label.lowercased())", text: $text)
                .textFieldStyle(.roundedBorder)
        }
    }
}
