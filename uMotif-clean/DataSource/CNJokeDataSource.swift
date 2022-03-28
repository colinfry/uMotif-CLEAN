//
//  CNJokeDataSource.swift
//  uMotif-clean
//
//  Created by Colin Fry on 26/03/2022.
//

import Foundation

protocol CNJokeDataSourceProtocol {
    func getCNJokes() async throws -> [CNJoke]
}

struct CNJokeDataSource: CNJokeDataSourceProtocol {
    
    var dataService: CNJokeServiceProtocol?
    
    func getCNJokes() async throws -> [CNJoke] {
        guard let jokes = try await dataService?.getJokes() else {
            throw ServiceError.generalError
        }
        return jokes
    }
}
