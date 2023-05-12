//
//  FetchableObject.swift
//  breaking-bad-client
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
        self.objectWillChange.send()
    }
}
