//
//  GameOfThronesTab.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 12/05/2023.
//


import SwiftUI

struct TabItemView<TDataSource: DataSource>: View {
    @StateObject var quoteStore:  DataStore<TDataSource>
    
    
    
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
                RandomQuoteView(seriesTitle: quoteStore.series.getFullName(), authorName: quoteStore.quote?.author ?? "", authorImageUrl: quoteStore.author?.image, content: quoteStore.quote?.content ?? "")
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


struct GameOfThronesTabView_Previews: PreviewProvider {
    static var previews: some View {
        let quoteStore = DataStore<GameOfThrones>()
        TabItemView(quoteStore: quoteStore)
            .preferredColorScheme(.dark)
    }
}

