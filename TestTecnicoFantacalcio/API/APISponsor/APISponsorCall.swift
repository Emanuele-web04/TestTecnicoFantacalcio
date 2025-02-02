//
//  APISponsorCall.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import Foundation

class APISponsorCall {
    func fetchSponsors() async throws -> [Sponsor] {
        // verifichiamo che l'url sia valido
        guard let url = URL(string: Endpoints.sponsorEndpoint) else {
            throw APIError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // stessa logica
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            let sponsors = try decoder.decode([Sponsor].self, from: data)
            
            return sponsors
        } catch {
            throw APIError.invalidData
        }
    }
}
