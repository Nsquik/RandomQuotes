//
//  RandomQuoteView.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 06/05/2023.
//

import SwiftUI

struct RandomQuoteView: View {
    var seriesTitle: String
    var authorName: String
    var authorImageUrl: URL?
    var content: String
    
    
    
    var body: some View {
                VStack{
                    Text(seriesTitle)
                        .font(.largeTitle)
                    Text(authorName)
                        .font(.title2)
                    Spacer(minLength: 60)
                    AsyncImage(url: authorImageUrl) { phase in
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
                    Text(content)
                        .font(.body)

                }
                .padding(.all, 20)
            }
        }
        
struct RandomQuoteView_Previews: PreviewProvider {
            static var previews: some View {
                RandomQuoteView(seriesTitle: Series.gameOfThrones.getFullName(), authorName: "Tyrion Lannister", authorImageUrl: URL(string: "https://fwcdn.pl/fph/68/48/476848/882019_1.2.jpg")!, content: "Kill him.")
                    .preferredColorScheme(.dark)
            }
}
