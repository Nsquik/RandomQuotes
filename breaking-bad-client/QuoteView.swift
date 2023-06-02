//
//  RandomQuoteView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import SwiftUI

struct QuoteView: View {
    var seriesTitle: String
    var authorName: String
    var authorImageUrl: URL?
    var content: String
    var isFavourite: Bool
    var onSaveAsFavouritePress: () -> Void
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(seriesTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(authorName)
                .font(.title2)
            Spacer(minLength: 60)
            
            VStack(alignment: .center) {
                AsyncImage(url: authorImageUrl) { phase in
                    switch phase {
                    case .empty:
                        VStack{}
                            .frame(width: 280, height: 320)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(20)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(maxWidth: 280, maxHeight: 320)
                            .cornerRadius(20)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .shadow(color: .white.opacity(0.2), radius: 30)
                .padding(.bottom, 40)
                Text("\"\(content)\"")
                    .italic()
                    .font(.headline)
                    .fontWeight(.medium)
                HStack{
                    Image(systemName: isFavourite ? "star.fill" : "star")
                        .foregroundColor(.yellow)

                        
                    Button(!isFavourite ? "Mark as favourite" : "Your favourite!") {
                        !isFavourite ? onSaveAsFavouritePress() : nil
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .center)

                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(seriesTitle: Series.gameOfThrones.getFullName(), authorName: "Tyrion Lannister", authorImageUrl: URL(string: "https://fwcdn.pl/fph/68/48/476848/882019_1.2.jpg")!, content: "Kill him.", isFavourite: true, onSaveAsFavouritePress: {
            print("save")
        })
            .preferredColorScheme(.dark)
    }
}
