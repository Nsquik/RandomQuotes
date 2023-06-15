//
//  GameOfThronesTab.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 12/05/2023.
//


import SwiftUI

struct QuoteTabItemView<Source: QuoteDataSource>: View {
    @ObservedObject var quoteStore: QuoteStore<Source>
    
    
    var body: some View {
        ScrollView {
            PhaseView(phase: quoteStore.phase){
                QuoteView(seriesTitle: quoteStore.series.getFullName(), authorName: quoteStore.quote?.author ?? "", authorImageUrl: quoteStore.author?.image, content: quoteStore.quote?.content ?? "", isFavourite: quoteStore.isFavourite,
                          onSaveAsFavouritePress: {
                    quoteStore.saveAsFavourite()
                    quoteStore.isFavourite = true
                })
            }
        }
        .onAppear {
            if case .success = quoteStore.phase {
                Task{
                    try await quoteStore.checkIsFavourite()
                }
            }
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
        let quoteStore = QuoteStore<BreakingBadDataSource>(series: .breakingBad)
        QuoteTabItemView(quoteStore: quoteStore)
            .preferredColorScheme(.dark)
    }
}

