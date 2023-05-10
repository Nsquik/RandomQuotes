//
//  RandomQuoteView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import SwiftUI

struct RandomQuoteView: View {
    @StateObject var quoteStore: QuoteStore
    @State var series: Series
    
    var body: some View {
        ScrollView {
            switch quoteStore.phase {
            case .loading:
                ProgressView()
            case .initial:
                EmptyView()
            case .fail(error: let error):
                Text(error)
            default:
                VStack{
                    Text(series.getFullName())
                        .font(.largeTitle)
                    Text(quoteStore.author?.name ?? "")
                        .font(.title2)
                    Spacer(minLength: 60)
                    AsyncImage(url: quoteStore.author?.image) { phase in
                        switch phase {
                        case .empty:
                            VStack{}
                                .frame(width: 250, height: 320)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(20)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 250)
                                .cornerRadius(20)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(.bottom, 40)
                    Text("\(quoteStore.quote?.content ?? "")")
                        .font(.body)

                }
                .padding(.all, 20)
            }
        }
        .onAppear {
            if case .success = quoteStore.phase {}
            else {
                    Task{
                        quoteStore.setup(series: series)
                        await quoteStore.load()
                    }
            }
        }
        .refreshable {
            Task{
                await quoteStore.refresh()
            }
        }
    }
}
        
struct RandomQuoteView_Previews: PreviewProvider {
            static var previews: some View {
                let quoteStore = QuoteStore()
                RandomQuoteView(quoteStore: quoteStore, series: .betterCallSaul)
                    .preferredColorScheme(.dark)
            }
}
