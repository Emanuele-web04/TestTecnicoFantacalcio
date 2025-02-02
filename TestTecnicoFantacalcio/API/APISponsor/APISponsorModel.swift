//
//  APISponsorModel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

/// Modello JSON
///
//[
//  {
//    "main": [
//      {
//        "tapUrl": "https://www.fantacalcio.it",
//        "image": "https://content.fantacalcio.it/test/List-1.png"
//      },
//      {
//        "tapUrl": "https://leghe.fantacalcio.it",
//        "image": "https://content.fantacalcio.it/test/List-2.png"
//      },
//      {
//        "tapUrl": null,
//        "image": "https://content.fantacalcio.it/test/List-3.png"
//      }
//    ],
//    "sectionId": "PLAYERS_LIST",
//    "description": "Lista calciatori"
//  },
//  {
//    "main": [
//      {
//        "tapUrl": "https://euroleghe.fantacalcio.it",
//        "image": "https://content.fantacalcio.it/test/Fav-1.png"
//      },
//      {
//        "tapUrl": "https://www.fantachampions.com",
//        "image": "https://content.fantacalcio.it/test/Fav-2.png"
//      },
//      {
//        "tapUrl": "https://www.twitch.tv/fantacalcio",
//        "image": "https://content.fantacalcio.it/test/Fav-3.png"
//      }
//    ],
//    "sectionId": "FAVOURITES",
//    "description": "Calciatori preferiti"
//  }
//]

import Foundation

struct Sponsor: Codable {
   let main: [MainObject]
   let sectionId: String
    
// devo modificare il nome "description" perché in swiftdata mi da errore poiche é una parola riservata
//   let sponsorDescription: String
//   
//   enum CodingKeys: String, CodingKey {
//       case main
//       case sectionId
//       case sponsorDescription = "description"
//   }
}

struct MainObject: Codable {
    let tapUrl: String?
    let image: String
}


