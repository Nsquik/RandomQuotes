//
//  Series.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 09/05/2023.
//

import Foundation


enum Series: String {
    case betterCallSaul
    case breakingBad
    
    
    func getFullName() -> String {
        switch self {
        case .betterCallSaul: return "Better Call Saul"
        case .breakingBad: return "Breaking Bad"
        }
    }
}
