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
    let apiPlayerCall = APIPlayerCall()
    @Query var players: [PlayerInfo]
    @Query var sponsors: [SponsorModel]
    @State private var sortedPlayers: [PlayerInfo] = []
    @State private var results: [PlayerInfo] = []
    @State private var apiError: Error? = nil
    @State private var isLoading = true
    @Environment(\.modelContext) var modelContext
    @State private var search = ""
    @FocusState var isFocused
    
    let apiSponsorCall = APISponsorCall()
    @State private var matchingSponsors: Sponsor? = nil
    let nullEndpoint = "https://content.fantacalcio.it/test/Fav-Default.png"
    
    let vm = SharedViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ScrollView {
                            LazyVStack {
                                if let matchingSponsors {
                                    ForEach(matchingSponsors.main, id: \.image) { sponsor in
                                        Main(main: sponsor)
                                    }
                                }
                            }
                        }
                        
                        // ho creato una custom searchbar anche sapendo dell'esistenza di .searchable
                        // perché la searchbar tende ad andare sopra tutto il contenuto
                        SearchBar(
                            isFocused: _isFocused,
                            search: $search,
                            prompt: "Cerca giocatori..."
                        ) {
                            // filtra i calciatori in base al nome
                            searchName()
                        }
                        .padding()
                        mainBlock
                    }
                }
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
                    apiError = error
                }
            }
        }
    }
    
    @ViewBuilder
    private func Main(main: MainObject) -> some View {
        
            if let tapUrl = main.tapUrl, let url = URL(string: tapUrl) {
                Button {
                    // se non si vuole usare UIApplication
                    // si puo anche usare NavigationLink con destination e label
                    UIApplication.shared.open(url)
                } label: {
                    if let validURL = URL(string: main.image) {
                        KFImage(validURL)
                    }
                }
            } else {
                if let url = URL(string: nullEndpoint) {
                    KFImage(url)
                }
            }
        
    }
    
    @ViewBuilder
    private var mainBlock: some View {
        if let apiError {
            Text(apiError.localizedDescription)
        } else {
            PlayersCells(players: totalPlayers)
        }
    }
    
    private func fetchAndSort() async throws {
        let fetchedPlayers = try await apiPlayerCall.fetchPlayers()
        populatePlayers(from: fetchedPlayers)
        await vm.sort(players, in: $sortedPlayers)
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
    
    private func fetchSponsors() async throws {
        let fetchedSponsors = try await apiSponsorCall.fetchSponsors()
        if sponsors.isEmpty {
            for sponsor in fetchedSponsors {
                let sponsorModel = SponsorModel(sponsor: sponsor)
                modelContext.insert(sponsorModel)
            }
            
            try? modelContext.save()
        }
        
        await MainActor.run {
            matchingSponsors = sponsors.first(where: { $0.sponsor.sectionId == "PLAYERS_LIST" })?.sponsor
        }
    }
    
    private func sorted() async {
        // se il team é lo stesso
        // sorta tra nomi
        // altrimenti sorta tra team
        let sorted = players.sorted {
            if $0.player.teamAbbreviation == $1.player.teamAbbreviation {
                return $0.player.playerName < $1.player.playerName
            } else {
                return $0.player.teamAbbreviation < $1.player.teamAbbreviation
            }
        }
        
        await MainActor.run {
            sortedPlayers = sorted
        }
    }
    
    private var searching: Bool {
        return !search.isEmpty && !isFocused
    }
    
    private var totalPlayers: [PlayerInfo] {
        return searching ? results : sortedPlayers
    }
    
    private func searchName() {
        // cosi se l utente sbaglia a digitare o mette uno spazio esce comunque il risultato
        let compactSearch = search
            .components(separatedBy: .whitespacesAndNewlines)
            .joined()
            .lowercased()
        
        let searchResult = sortedPlayers.filter {
            let compactPlayerName = $0.player.playerName
                .components(separatedBy: .whitespacesAndNewlines)
                .joined()
                .lowercased()
            
            return compactPlayerName.contains(compactSearch)
        }
        
        results = searchResult
    }
}

#Preview {
    PlayerListView()
}
