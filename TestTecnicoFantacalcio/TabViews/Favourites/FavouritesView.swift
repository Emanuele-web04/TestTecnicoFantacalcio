//
//  FavouritesView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    @Query var sponsors: [SponsorModel]
    @Query var players: [PlayerInfo]
    
    @ObservedObject var vm = SharedViewModel()
    @StateObject var favVM = FavViewModel()
    let nullEndpoint = "https://content.fantacalcio.it/test/List-Default.png"
    @AppStorage("favCounter") var j = 0
    let sectionId = "FAVOURITES"
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if let sponsorToShow = favVM.sponsorToShow {
                            SponsorImage(sponsor: sponsorToShow, nullEndpoint: nullEndpoint)
                        }
                        StatsLabel()
                        PlayersCells(players: favVM.favourites, favouriteView: true)
                    }
                }
                .ignoresSafeArea()
                .vAlign(.top)
                .hAlign(.center)
            }
            .onAppear {
                // filter and sort
                favouritesSort()
                Task {
                    await vm.assignMatchingSponsors(sponsors, with: sectionId) {
                        updateSponsor()
                    }
                }
            }
        }
    }
}

// MARK: - FUNZIONI E VARIABILI
extension FavouritesView {
    private func updateSponsor() {
        if j == 2 {
            favVM.sponsorToShow = vm.matchingSponsors?.main[j]
            j = 0
        } else {
            favVM.sponsorToShow = vm.matchingSponsors?.main[j]
            j += 1
        }
    }
    
    private func favouritesSort() {
        let filtered = players.filter {
            $0.isFavourite
        }
        
        Task {
            await vm.sort(filtered, in: $favVM.favourites)
        }
    }
}

#Preview {
    FavouritesView()
}
