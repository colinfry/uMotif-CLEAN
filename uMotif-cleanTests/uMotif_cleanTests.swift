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
        let contentVM = await ContentViewModel(getJokeUseCase: nil)
        XCTAssertFalse(contentVM == nil)
    }

    func testContentViewModel_shouldReturnZeroJokes () async throws {
        let useCase = CNJokeGetUseCase_ErrorMock(dataSource: nil)
        let contentVM = await ContentViewModel(getJokeUseCase: useCase)
        let jokes = await contentVM.jokes
        XCTAssertTrue(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 0)
    }
    
    func testContentViewModel_shouldReturnTwoJokes () async throws {
        let dataSource = CNJokeDataSource_TwoJokesMock()
        let useCase = CNGetJokeUseCase(dataSource: dataSource)
        let contentVM = await ContentViewModel(getJokeUseCase: useCase)
        await contentVM.getJokes()
        let jokes = await contentVM.jokes
        let error = await contentVM.hasError
        XCTAssertFalse(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 2)
        XCTAssertFalse(error)
    }
    
    func testContentViewModel_shouldDisplayErrorMessage () async throws {
        let useCase = CNJokeGetUseCase_ErrorMock(dataSource: nil)
        let contentVM = await ContentViewModel(getJokeUseCase: useCase)
        await contentVM.getJokes()
        let jokes = await contentVM.jokes
        let error = await contentVM.hasError
        let message = await contentVM.errorMessage
        XCTAssertTrue(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 0)
        XCTAssertTrue(error)
        XCTAssertEqual(message, "The operation couldn’t be completed. (uMotif_clean.UseCaseError error 0.)")
    }
    
    func testContentViewModel_testLiveService () async throws {
        let service = CNJokeService()
        let dataSource = CNJokeDataSource(dataService: service)
        let useCase = CNGetJokeUseCase(dataSource: dataSource)
        let contentVM = await ContentViewModel(getJokeUseCase: useCase)
        await contentVM.getJokes()
        let jokes = await contentVM.jokes
        let error = await contentVM.hasError
        
        XCTAssertFalse(jokes.isEmpty)
        XCTAssertEqual(jokes.count, 55)
        XCTAssertEqual(error, false)
    }

}
