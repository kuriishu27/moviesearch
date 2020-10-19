//
//  MovieSearchTests.swift
//  MovieSearchTests
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import XCTest
import Combine
@testable import MovieSearch

class MovieSearchTests: XCTestCase {

	var movieFactory: MovieFactory!
	var resData: (Result<[Movie],Error>)? = nil

	var moviePresenter: MoviesPresenter!

	override func setUp() {
		self.movieFactory = MovieFactoryFromJSONImpl()
		self.moviePresenter = MoviesPresenterImpl(movieFactory)
	}

	func testSuccessGetMoviesRepository() {

		let exp =  self.expectation(description: "Result complete")
		let expectedValue: [Movie] = [Movie(title: "Title", year: "2020", imageURL: "something")]

		// 1. Given - the component that you want to test
		self.movieFactory = MovieFactoryFromJSONImpl()
		self.moviePresenter = MoviesPresenterImpl(movieFactory)

		// 2. When - we call the .getMovies function
		movieFactory.getMovies { result in
			self.resData = result
			switch(result) {
				case .success(let movies):

					// 3. Then - We want to assert and verify that the result is correct through assertions.
					XCTAssertTrue(movies.count > 0,"Must be greater than 0. There are \(movies.count)")

					exp.fulfill()

				case .failure(let error):
					XCTFail(error.localizedDescription)

					exp.fulfill()
			}
		}

		wait(for: [exp], timeout: 3)
	}

	func testMoviesToShowFromPresenter() {
		let exp =  self.expectation(description: "Result complete")

		moviePresenter.getMovies { result in
			switch(result) {
				case .success:
					exp.fulfill()
				case .failure(let error):
					XCTAssertNotNil(error, "Error")

					exp.fulfill()

			}
		}

		wait(for: [exp], timeout: 3)

	}

	func testDecodeMovie() {

		let decoder = JSONDecoder()

		let json = Bundle.main.path(forResource: "movies", ofType: "json")!
		let data = json.data(using: .utf8)!

		let movies = try! decoder.decode([Movie].self, from: data)

	}

}
