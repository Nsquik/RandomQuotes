//
//  ContentView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    let betterCallSaulStore = QuoteStore()
    let breakingBadStore = QuoteStore()
    var body: some View {
            TabView {
                RandomQuoteView(quoteStore: betterCallSaulStore, series: .betterCallSaul)
                    .tabItem{Label("Better Call Saul", systemImage: "briefcase")}
                RandomQuoteView(quoteStore: breakingBadStore, series: .breakingBad)
                    .tabItem{Label("Breaking bad", systemImage: "briefcase")}
            }
            .onAppear{
                UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
