//
//  SponsorModel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI
import SwiftData

@Model
final class SponsorModel {
    // se vedete nella cronologia dei commit ho cambiato il modello
    // perchè la parola description era riservata e quindi ho dovuto smantellare il modello e prenderlo pezzo pezzo
    var sponsor: [MainObject]
    var sectionId: String
    var sponsorDesc: String
    
    init(sponsor: Sponsor) {
        self.sponsor = sponsor.main
        self.sectionId = sponsor.sectionId
        self.sponsorDesc = sponsor.description
    }
}
