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
    @State private var favourites: [PlayerInfo] = []
    @ObservedObject var vm = SharedViewModel()
    @State private var sponsorToShow: MainObject? = nil
    let nullEndpoint = "https://content.fantacalcio.it/test/List-Default.png"
    @AppStorage("favCounter") var j = 0
    let sectionId = "FAVOURITES"
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if let sponsorToShow {
                            SponsorImage(sponsor: sponsorToShow, nullEndpoint: nullEndpoint)
                        }
                        StatsLabel()
                        PlayersCells(players: favourites, favouriteView: true)
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
    
    private func updateSponsor() {
        if j == 2 {
            sponsorToShow = vm.matchingSponsors?.main[j]
            j = 0
            print(sponsorToShow?.image ?? "")
        } else {
            sponsorToShow = vm.matchingSponsors?.main[j]
            j += 1
            print(sponsorToShow?.image ?? "")
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
