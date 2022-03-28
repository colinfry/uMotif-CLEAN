//
//  uMotif_cleanTests.swift
//  uMotif-cleanTests
//
//  Created by Colin Fry on 26/03/2022.
//

import XCTest
@testable @preconcurrency import uMotif_clean

class uMotif_cleanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContentViewModel_shouldExist() async throws {
        let contentVM = await ContentViewModel(getJokesUseCase: nil)
    }

    func testContentViewModel_shouldReturnZeroJokes () async throws {
        let useCase = CNJokesGetUseCase_ErrorMock(dataSource: nil)
        let contentVM = await ContentViewModel(getJokesUseCase: useCase)
        let jokes = await contentVM.jokes
        XCTAssertTrue(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 0)
    }
    
    func testContentViewModel_shouldReturnTwoJokes () async throws {
        let dataSource = CNJokesDataSource_TwoJokesMock()
        let useCase = GetJokesUseCase(dataSource: dataSource)
        let contentVM = await ContentViewModel(getJokesUseCase: useCase)
        await contentVM.getJokes()
        let jokes = await contentVM.jokes
        XCTAssertFalse(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 2)
    }
    
    func testContentViewModel_shouldDisplayErrorMessage () async throws {
        let useCase = CNJokesGetUseCase_ErrorMock(dataSource: nil)
        let contentVM = await ContentViewModel(getJokesUseCase: useCase)
        await contentVM.getJokes()
        let jokes = await contentVM.jokes
        let error = await contentVM.hasError
        let message = await contentVM.errorMessage
        XCTAssertTrue(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 0)
        XCTAssertEqual(error, true)
        XCTAssertEqual(message, "The operation couldn’t be completed. (uMotif_clean.UseCaseError error 0.)")
    }

}
