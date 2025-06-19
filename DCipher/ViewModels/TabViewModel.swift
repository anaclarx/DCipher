//
//  TabViewModel.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 11/06/25.
//

import SwiftUI

@Observable
class TabViewModel {
    var currentTab: TabItem = .menu

    func switchTo(_ tab: TabItem) {
        currentTab = tab
    }
}
