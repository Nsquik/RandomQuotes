//
//  GameOfThronesTab.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//


import SwiftUI

struct QuoteTabItemView<Source: QuoteDataSource>: View {
    @StateObject var quoteStore: QuoteStore<Source>
    
    var body: some View {
        ScrollView {
            switch quoteStore.phase {
            case .loading:
                ProgressView()
            case .initial:
                EmptyView()
            case .fail(error: let error):
                Image(systemName: "flag.filled.and.flag.crossed")
                    .resizable()
                    .frame(width: 120, height: 80)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.red.opacity(0.8))
                Text(error)
            default:
                QuoteView(seriesTitle: quoteStore.series.getFullName(), authorName: quoteStore.quote?.author ?? "", authorImageUrl: quoteStore.author?.image, content: quoteStore.quote?.content ?? "", isFavourite: quoteStore.isFavourite,
                          onSaveAsFavouritePress: {
                    quoteStore.saveAsFavourite()
                    quoteStore.isFavourite = true
                })
            }
        }
        .onAppear {
            if case .success = quoteStore.phase {}
            else {
                Task{
                    await quoteStore.load()
                }
            }
        }
        .refreshable {
            await quoteStore.refresh()
        }
    }
}


struct QuoteTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        let quoteStore = QuoteStore<GameOfThronesDataSource>(series: .gameOfThrones)
        QuoteTabItemView(quoteStore: quoteStore)
            .preferredColorScheme(.dark)
    }
}

