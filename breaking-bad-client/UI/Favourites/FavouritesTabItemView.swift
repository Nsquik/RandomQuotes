//
//  FavouritesTabItemView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 02/06/2023.
//

import SwiftUI

struct FavouritesTabItemView: View {
    @StateObject var favouritesStore: FavouritesStore
    @State var editMode = EditMode.active
    @State private var multiSelection = Set<UUID>()

    
    var body: some View {
        NavigationView {
            List{
                !favouritesStore.breakingBadQuotes.isEmpty ? Section(Series.breakingBad.getFullName()){
                    ForEach(favouritesStore.breakingBadQuotes){
                        Text($0.content ?? "...")
                    }
                    .onDelete{indexSet in
                        favouritesStore.deleteQuote(indexSet, series: .breakingBad)
                    }
                } : nil
                !favouritesStore.betterCallSaulQuotes.isEmpty ? Section(Series.betterCallSaul.getFullName()){
                    ForEach(favouritesStore.betterCallSaulQuotes){
                        Text($0.content ?? "...")
                    }
                    .onDelete{indexSet in
                        favouritesStore.deleteQuote(indexSet, series: .betterCallSaul)
                    }
                } : nil
                !favouritesStore.gameOfThronesQuotes.isEmpty ? Section(Series.gameOfThrones.getFullName()){
                    ForEach(favouritesStore.gameOfThronesQuotes){
                        Text($0.content ?? "...")
                    }
                    .onDelete{indexSet in
                        favouritesStore.deleteQuote(indexSet, series: .gameOfThrones)
                    }
                } : nil
            }
            .navigationTitle("Your favourite quotes")
            .toolbar {
                EditButton()
            }

        }
        .onAppear {
                Task{
                    await favouritesStore.load()
                }
        }
    }
}

struct FavouritesTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        let favouritesStore = FavouritesStore()
        
        FavouritesTabItemView(favouritesStore: favouritesStore)
    }
}
