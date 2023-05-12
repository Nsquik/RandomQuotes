//
//  Series.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation

enum Series {
    case betterCallSaul
    case gameOfThrones
    
    
    func getFullName() -> String {
        switch self {
        case .betterCallSaul: return "Better Call Saul"
        case .gameOfThrones: return "Game Of Thrones"
        }
    }
}
