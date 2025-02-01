//
//  APICall.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import Foundation

class APICall: ObservableObject {
    // endpoint = location da dove la chiamata prende i dati
    let endpoint = "https://content.fantacalcio.it/test/test.json"
    
    func fetchPlayers() async throws -> [Player] {
        // verifichiamo che l'url sia valido
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // check se la risposta é di 200, se é di 200 vuol dire che non ci sono stati errori di server o connessione
            // se non é 200 lancia un errore che verrá poi mostrato all'utente
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            // decodifichiamo da JSON a Players
            let decoder = JSONDecoder()
            let players = try decoder.decode([Player].self, from: data)
            
            return players
        } catch {
            throw APIError.invalidData
        }
    }
}
