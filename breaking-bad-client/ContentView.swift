//
//  ContentView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var breakingBadStore = QuoteStore<BreakingBadDataSource>(series: .breakingBad)
    var betterCallSaulStore = QuoteStore<BetterCallSaulDataSource>(series: .betterCallSaul)
    var gameOfThronesStore = QuoteStore<GameOfThronesDataSource>(series: .gameOfThrones)
    
    var body: some View {
        TabView {
            QuoteTabItemView(quoteStore: breakingBadStore)
                .tabItem{Label(breakingBadStore.series.getFullName(), systemImage: "mouth")}
            QuoteTabItemView(quoteStore: betterCallSaulStore)
                .tabItem{Label(betterCallSaulStore.series.getFullName(), systemImage: "briefcase")}
            QuoteTabItemView(quoteStore: gameOfThronesStore)
                .tabItem{Label(gameOfThronesStore.series.getFullName(), systemImage: "oar.2.crossed")}
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
