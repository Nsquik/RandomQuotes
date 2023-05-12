//
//  ContentView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var gameOfThronesStore = DataStore<GameOfThrones>()
    var breakingBadStore = DataStore<BreakingBad>()
    
    var body: some View {
        TabView {
            TabItemView(quoteStore: gameOfThronesStore)
                .tabItem{Label(gameOfThronesStore.series.getFullName(), systemImage: "briefcase")}
            TabItemView(quoteStore: breakingBadStore)
                .tabItem{Label(breakingBadStore.series.getFullName(), systemImage: "briefcase")}
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
