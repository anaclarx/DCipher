//
//  Status.swift
//  DCipher
//
//  Created by Ana Clara Filgueiras Granato on 14/07/25.
//


enum Status: String, CaseIterable {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case memorized = "Memorized"
    case needsImprovement = "Needs Improvement"
    case ready = "Ready"
    case mastered = "Mastered"
    case onHold = "On Hold"
    case abandoned = "Abandoned"
}
