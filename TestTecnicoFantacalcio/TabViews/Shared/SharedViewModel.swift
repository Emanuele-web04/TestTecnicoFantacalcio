//
//  ViewModel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    let apiSponsorCall = APISponsorCall()
    @Published var matchingSponsors: Sponsor? = nil
    @Published var sponsorToShow: MainObject? = nil
    
    func assignMatchingSponsors(_ sponsors: [SponsorModel],
                              with sectionId: String,
                              updateSponsor: @escaping () -> Void) async {
        await MainActor.run {
            matchingSponsors = sponsors.first(where: { $0.sponsor.sectionId == sectionId })?.sponsor
            updateSponsor()
        }
    }
    
    func sort(_ players: [PlayerInfo], in sortedPlayers: Binding<[PlayerInfo]>) async {
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
            sortedPlayers.wrappedValue = sorted
        }
    }
}
