//
//  MovieSearchTests.swift
//  MovieSearchTests
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieSearchTests: XCTestCase {

   var movieFactory: MovieFactory!
   var resData: (Result<[Movie],Error>)? = nil
  
  var moviePresenter: MoviesPresenter!
   
   override func setUp() {
      self.movieFactory = MovieFactoryFromJSONImpl()
      self.moviePresenter = MoviesPresenterImpl(movieFactory)
    }
   


   func testGetMoviesRepository() {
     
     let exp =  self.expectation(description: "Result complete")
     
     movieFactory.getMovies { result in
        self.resData = result
        switch(result) {
        case .success(let movies):
         exp.fulfill()
          XCTAssertTrue(movies.count > 0,"Must be greater than 0. There are \(movies.count)")
        case .failure(let error):
          XCTAssertNotNil(error, "Error")
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
      }
    }
  }

}
