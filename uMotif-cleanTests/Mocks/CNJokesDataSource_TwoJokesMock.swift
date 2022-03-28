//
//  CNJokesGet-UseCase-Mock.swift
//  uMotif-cleanTests
//
//  Created by Colin Fry on 27/03/2022.
//

import Foundation
@testable import uMotif_clean

struct CNJokesDataSource_TwoJokesMock: CNJokeDataSourceProtocol {
    
    var dataService: CNJokeServiceProtocol?
    
    func getCNJokes() async throws -> [CNJoke] {
        let joke1 = CNJoke(id: 0, joke: "Joke1", categories: [])
        let joke2 = CNJoke(id: 1, joke: "Joke2", categories: [])
        return [joke1, joke2]
    }
}
