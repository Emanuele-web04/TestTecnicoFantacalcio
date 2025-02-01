//
//  FavouritesView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    
    @Query var players: [PlayerInfo]
    @State private var favourites: [PlayerInfo] = []
    let vm = SharedViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        Rectangle()
                            .hAlign(.center)
                            .frame(height: 150, alignment: .top)
                            .ignoresSafeArea()
                        StatsLabel()
                        PlayersCells(players: favourites, favouriteView: true)
                    }
                }
                .vAlign(.top)
                .hAlign(.center)
            }
            .onAppear {
                // filter and sort
                favouritesSort()
            }
        }
    }
    
    
    
    private func favouritesSort() {
        let filtered = players.filter {
            $0.isFavourite
        }
        
        Task {
            await vm.sort(filtered, in: $favourites)
        }
    }
}

#Preview {
    FavouritesView()
}
