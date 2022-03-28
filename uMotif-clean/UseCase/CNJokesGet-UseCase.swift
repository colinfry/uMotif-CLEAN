//
//  CNJokesGet-UseCase.swift
//  uMotif-clean
//
//  Created by Colin Fry on 26/03/2022.
//

import Foundation

protocol GetJokesUseCaseProtocol {
    func execute() async -> Result<[CNJoke], UseCaseError>
}

struct GetJokesUseCase: GetJokesUseCaseProtocol {

    var dataSource: CNJokeDataSourceProtocol?
    
    func execute() async -> Result<[CNJoke], UseCaseError> {
        
        do {
            guard let jokes = try await dataSource?.getCNJokes()  else {
                return .failure(.decodingError)
            }
            return .success(jokes)
            
        } catch(let error) {
            
            switch(error) {
            case ServiceError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
