//
//  MovieViewModelTests.swift
//  MovieSearchTests
//
//  Created by Christian Leovido on 16/10/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import XCTest

final class MovieViewModel {

	func sum(number: Int, number2: Int) -> Int {
		return number + number2
	}
}

enum ExpectedResults {
	static let sumResult = 2
}

class MovieViewModelTests: XCTestCase {

	var sut: MovieViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

//		let exp = XCTestExpectation(description: <#T##String#>)

		// 1. Given
		sut = MovieViewModel()

		// When
		let result = sut.sum(number: 1, number2: 1)


		// Then
		XCTAssertEqual(result, ExpectedResults.sumResult)

    }

}
