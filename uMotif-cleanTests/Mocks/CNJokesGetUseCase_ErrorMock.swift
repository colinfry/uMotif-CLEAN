//
//  CNJokesGetUseCase_ErrorMock.swift
//  uMotif-cleanTests
//
//  Created by Colin Fry on 28/03/2022.
//

import Foundation
@testable import uMotif_clean

struct CNJokesGetUseCase_ErrorMock: GetJokesUseCaseProtocol {

    var dataSource: CNJokeDataSourceProtocol?
    
    func execute() async -> Result<[CNJoke], UseCaseError> {
        return Result.failure(UseCaseError.networkError)
    }
}
