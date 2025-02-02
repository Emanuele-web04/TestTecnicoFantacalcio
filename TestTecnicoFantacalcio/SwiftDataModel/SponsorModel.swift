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
    
    init(sponsor: Sponsor) {
        self.sponsor = sponsor
    }
}
