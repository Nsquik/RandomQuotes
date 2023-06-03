//
//  Series.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation

enum Series: String {
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
    case gameOfThrones = "Game of Thrones"
    
    
    
    static func getSeries(rawValue: String?) -> Self? {
        switch rawValue {
            case "Breaking Bad": return Series.breakingBad
            case "Better Call Saul": return Series.betterCallSaul
            case "Game of Thrones": return Series.gameOfThrones
            default: return nil
        }
    }
    
    func getFullName() -> String {
        switch self {
            case .breakingBad: return "Breaking Bad"
            case .gameOfThrones: return "Game of Thrones"
            case .betterCallSaul: return "Better Call Saul"
        }
    }
}
