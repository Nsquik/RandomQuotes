//
//  ContentView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var gameOfThronesStore = DataStore<GameOfThrones>()
    var otherTVShowStore = DataStore<BetterCallSaul>()
    
    var body: some View {
            TabView {
                TabItemView(quoteStore: gameOfThronesStore)
                    .tabItem{Label(gameOfThronesStore.series.getFullName(), systemImage: "briefcase")}
                TabItemView(quoteStore: otherTVShowStore)
                    .tabItem{Label(otherTVShowStore.series.getFullName(), systemImage: "briefcase")}
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
