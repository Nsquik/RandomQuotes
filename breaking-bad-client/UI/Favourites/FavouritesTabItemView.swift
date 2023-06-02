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
                Section("Breaking bad"){
                    ForEach(favouritesStore.quotes ?? []){
                        Text($0.content ?? "...")
                    }
                    .onDelete{indexSet in
                        
                    }
                }
            }
            .toolbar {
                EditButton()
            }

        }
        .onAppear {
            if case .success = favouritesStore.phase {}
            else {
                Task{
                    await favouritesStore.load()
                }
            }
        }
        .refreshable {
            await favouritesStore.refresh()
        }
    }
}

struct FavouritesTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        let favouritesStore = FavouritesStore()
        
        FavouritesTabItemView(favouritesStore: favouritesStore)
    }
}
