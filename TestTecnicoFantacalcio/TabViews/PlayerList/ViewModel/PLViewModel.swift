//
//  PLViewModel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 02/02/25.
//

import SwiftUI

class PLViewModel: ObservableObject {
    let apiPlayerCall = APIPlayerCall()
    @Published var sponsorToShow: MainObject? = nil
    @Published var sortedPlayers: [PlayerInfo] = []
    @Published var results: [PlayerInfo] = []
    @Published var search = ""
    @Published var searched = false
    @Published var apiError: Error? = nil
    
    func onChangeofSearch() {
        if search.isEmpty {
            searched = false
        }
    }
    
    func searchName() {
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
        searched = true
        results = searchResult
    }
}
