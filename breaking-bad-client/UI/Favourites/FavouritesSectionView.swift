//
//  FavouritesSectionView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 04/06/2023.
//

import SwiftUI

struct FavouritesSectionView: View {
    var quotes: [FavouriteQuote]
    var series: Series
    var onDelete: (IndexSet, Series) -> Void
    
    var body: some View {
        if !quotes.isEmpty {
            Section(series.getFullName()) {
                ForEach(quotes) { quote in
                    Text(quote.content ?? "...")
                }
                .onDelete { indexSet in
                    onDelete(indexSet, series)
                }
            }
        }
    }
}

struct FavouritesSectionView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesSectionView(quotes: [], series: .breakingBad, onDelete: {_,_  in })
    }
}
