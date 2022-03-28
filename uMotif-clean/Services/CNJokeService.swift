//
//  ServiceProtocol.swift
//  uMotif-clean
//
//  Created by Colin Fry on 26/03/2022.
//

import Foundation

protocol CNJokeServiceProtocol {
    func getJokes() async throws -> [CNJoke]
}

struct CNJokeService: CNJokeServiceProtocol {
        
    func getJokes() async throws -> [CNJoke] {
        
        guard let url = URL(string: ServiceEndpoints.cnJokes.rawValue) else {
            throw ServiceError.urlError
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw ServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ServiceError.statusError
        }
        
        guard let result = try? JSONDecoder().decode(CNJokeResponse.self, from: data),
              let jokes = result.jokes else {
            throw ServiceError.decodingError
        }
        
        return jokes
    }
}
