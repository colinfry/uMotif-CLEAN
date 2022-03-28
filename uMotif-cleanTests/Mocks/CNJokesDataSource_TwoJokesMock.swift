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
        return [CNJoke.example, CNJoke.example]
    }
}
