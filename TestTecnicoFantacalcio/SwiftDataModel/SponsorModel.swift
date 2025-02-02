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
    var sponsor: Sponsor
    var lastPlayerSponsor: Sponsor? = nil
    var lastFavouriteSponsor: Sponsor? = nil
    
    init(sponsor: Sponsor, lastPlayerSponsor: Sponsor? = nil, lastFavouriteSponsor: Sponsor? = nil) {
        self.sponsor = sponsor
        self.lastPlayerSponsor = lastPlayerSponsor
        self.lastFavouriteSponsor = lastFavouriteSponsor
    }
}
