//
//  FetchableObject.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import Foundation

enum FetchableObjectPhase {
    case initial
    case loading
    case success
    case fail(error: String)
}


enum FetchableObjectError: Error {
    case decoding
}

class FetchableObject: ObservableObject {
    
    @Published var phase: FetchableObjectPhase = .initial
    
    @MainActor
    open func fetchData() async {}
    
    @MainActor
    func load() async {
        phase = .loading
        await fetchData()
    }
    
    @MainActor
    func refresh() async {
        await fetchData()
    }
}
