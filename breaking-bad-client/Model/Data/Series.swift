//
//  Series.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation

enum Series {
    case breakingBad
    case gameOfThrones
    
    func getFullName() -> String {
        switch self {
        case .breakingBad: return "Breaking Bad"
        case .gameOfThrones: return "Game of Thrones"
        }
    }
}
