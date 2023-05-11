//
//  ContentView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    let betterCallSaulStore = QuoteStore<BetterCallSaul, BetterCallSaul>()
    let breakingBadStore = QuoteStore<GameOfThrones, GameOfThrones>()
    
    var body: some View {
            TabView {
                RandomQuoteView(quoteStore: betterCallSaulStore, series: .betterCallSaul)
                    .tabItem{Label(Series.betterCallSaul.getFullName(), systemImage: "briefcase")}
                RandomQuoteView(quoteStore: breakingBadStore, series: .gameOfThrones)
                    .tabItem{Label(Series.gameOfThrones.getFullName(), systemImage: "briefcase")}
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
