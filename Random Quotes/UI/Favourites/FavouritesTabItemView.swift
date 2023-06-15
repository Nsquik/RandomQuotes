//
//  FavouritesTabItemView.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 02/06/2023.
//

import SwiftUI

struct FavouritesTabItemView: View {
    @ObservedObject var favouritesStore: FavouritesStore
    
    
    var body: some View {
        NavigationView {
            List{
                FavouritesSectionView(quotes: favouritesStore.breakingBadQuotes, series: .breakingBad, onDelete: favouritesStore.deleteQuote)
                FavouritesSectionView(quotes: favouritesStore.betterCallSaulQuotes, series: .betterCallSaul, onDelete: favouritesStore.deleteQuote)
                FavouritesSectionView(quotes: favouritesStore.gameOfThronesQuotes, series: .gameOfThrones, onDelete: favouritesStore.deleteQuote)
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
