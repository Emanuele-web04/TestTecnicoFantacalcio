//
//  Model.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

/// Modello JSON
///
/// Ho un'array di oggetto di tipo Player, coi vari campi indicati
//[
    //{
    //    "averageGrade": 6.23,
    //    "teamAbbreviation": "NAP",
    //    "playerId": 572,
    //    "playerName": "Meret",
    //    "imageURL": "https://d22uzg7kr35tkk.cloudfront.net/web/campioncini/medium/MERET.png?v=26",
    //    "averageFantaGrade": 5.73,
    //    "gamesPlayed": 24
    //},
    //...
//]



import Foundation

// Tipo Codable cosi possiamo Encodificare e Decodificarlo in JSON quando faremo la chiamata API e restituiremo l'array di Player
struct Player: Codable {
    let averageGrade: Double
    let teamAbbreviation: String
    let playerId: Int
    let playerName: String
    let imageURL: String
    let averageFantaGrade: Double
    let gamesPlayed: Int
}
