//
//  Endpoints.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 02/02/25.
//

import Foundation

struct Endpoints {
    static let playerEndpoint = "https://content.fantacalcio.it/test/test.json"
    static let sponsorEndpoint = "https://content.fantacalcio.it/test/sponsor.json"

    
    static let nullPlayerEndpoint = "https://content.fantacalcio.it/test/List-Default.png"
    // non usata poiché dal json non ci sono null, ma nel caso ci dovessero essere, questo é l endpoint
    static let nullFavEndpoint = "https://content.fantacalcio.it/test/Fav-Default.png"
}
