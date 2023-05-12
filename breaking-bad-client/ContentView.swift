//
//  ContentView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var breakingBadStore = DataStore(series: .breakingBad)
    var betterCallSaulStore = DataStore(series: .betterCallSaul)
    var gameOfThronesStore = DataStore(series: .gameOfThrones)
    
    var body: some View {
        TabView {
            TabItemView(quoteStore: breakingBadStore)
                .tabItem{Label(breakingBadStore.series.getFullName(), systemImage: "mouth")}
            TabItemView(quoteStore: betterCallSaulStore)
                .tabItem{Label(betterCallSaulStore.series.getFullName(), systemImage: "briefcase")}
            TabItemView(quoteStore: gameOfThronesStore)
                .tabItem{Label(gameOfThronesStore.series.getFullName(), systemImage: "oar.2.crossed")}
        }
        .onAppear{
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
            UITabBar.appearance().tintColor = .green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
