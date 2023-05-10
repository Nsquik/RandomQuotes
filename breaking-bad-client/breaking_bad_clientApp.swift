//
//  breaking_bad_clientApp.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

@main
struct breaking_bad_clientApp: App {
    let quoteStore = QuoteStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
