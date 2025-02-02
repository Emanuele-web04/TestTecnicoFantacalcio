//
//  ListaCalciatoriView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI
import SwiftData
import Kingfisher

struct PlayerListView: View {
    @Query var players: [PlayerInfo]
    @Query var sponsors: [SponsorModel]
    
    @State private var isLoading = true
    @Environment(\.modelContext) var modelContext
    
    @FocusState var isFocused
    
    @AppStorage("counter") var i = 0
    @ObservedObject var vm = SharedViewModel()
    @StateObject var plVM = PLViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if let sponsorToShow = plVM.sponsorToShow {
                            SponsorImage(sponsor: sponsorToShow, nullEndpoint: Endpoints.nullPlayerEndpoint)
                        }
                        
                        // ho creato una custom searchbar anche sapendo dell'esistenza di .searchable
                        // perché la searchbar tende ad andare sopra tutto il contenuto
                        SearchBar(
                            isFocused: _isFocused,
                            search: $plVM.search,
                            prompt: "Cerca giocatori..."
                        ) {
                            // filtra i calciatori in base al nome
                            plVM.searchName()
                        }
                        .onChange(of: plVM.search, {
                            plVM.onChangeofSearch()
                        })
                        .padding()
                        
                        allPlayers
                    }
                }
                .ignoresSafeArea()
                .vAlign(.top)
                .hAlign(.center)
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .task {
                do {
                    try await fetchAndSort()
                    try await fetchSponsors()
                } catch {
                    plVM.apiError = error
                }
            }
        }
    }
}

// MARK: - FUNZIONI E VARIABILI
extension PlayerListView {
    private func updateSponsor() {
        guard let matchingSponsors = vm.matchingSponsors?.main else { return }
        
        if i == (matchingSponsors.count - 1) {
            plVM.sponsorToShow = vm.matchingSponsors?.main[i]
            i = 0
        } else {
            plVM.sponsorToShow = vm.matchingSponsors?.main[i]
            i += 1
        }
    }
    
    @ViewBuilder
    private var allPlayers: some View {
        if let apiError = plVM.apiError {
            Text(apiError.localizedDescription)
        } else {
            if plVM.searched && plVM.results.isEmpty {
                ContentUnavailableView("No results for \(plVM.search)", systemImage: "magnifyingglass")
            } else {
                PlayersCells(players: totalPlayers)
            }
        }
    }

    private func fetchAndSort() async throws {
        let fetchedPlayers = try await plVM.apiPlayerCall.fetchPlayers()
        populatePlayers(from: fetchedPlayers)
        await vm.sort(players, in: $plVM.sortedPlayers)
        isLoading = false
    }
    
    private func populatePlayers(from fetchedPlayers: [Player]) {
        // se la query é vuota, proseguire con l'aggiungere i giocatori fetchati
        // se invece é giá piena, ovvero coi contenuti fetchati, non fare niente
        //
        // questa non é una soluzione scalabile, ho usato questa solo per lo scopo di questo test
        // per essere scalabile si potrebbe controllare la data di aggiornamento dell'endpoint
        // se le date sono diverse allora aggiornare
        if players.isEmpty {
            for player in fetchedPlayers {
                let playerInfo = PlayerInfo(player: player)
                modelContext.insert(playerInfo)
            }
            
            // forziamo subito il save in modo tale da sortare subito dopo
            try? modelContext.save()
        }
    }
    
    // mettere in comune
    private func fetchSponsors() async throws {
        let fetchedSponsors = try await vm.apiSponsorCall.fetchSponsors()
        if sponsors.isEmpty {
            for sponsor in fetchedSponsors {
                let sponsorModel = SponsorModel(sponsor: sponsor)
                modelContext.insert(sponsorModel)
            }
            
            try? modelContext.save()
        }
        
        await vm.assignMatchingSponsors(sponsors, with: SectionsID.sectionPlayedId) {
            updateSponsor()
        }
    }
    
    private var searching: Bool {
        return !plVM.search.isEmpty && !isFocused
    }
    
    private var totalPlayers: [PlayerInfo] {
        return searching ? plVM.results : plVM.sortedPlayers
    }
}

#Preview {
    PlayerListView()
}
