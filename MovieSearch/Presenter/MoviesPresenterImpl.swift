//
//  MoviesPresenterImpl.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

class MoviesPresenterImpl: MoviesPresenter {
 
  let movieFactory: MovieFactory
  var movies : [Movie] = []
  
  init(_ movieFactory: MovieFactory) {
    self.movieFactory = movieFactory
   }
  
// MARK: -  Presenter Owner <--> Presenter
  
  func moviesToShow(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
      // Retrieve movies from repository
      movieFactory.getMovies { result in
        switch(result) {
        case .success(let movies):
          self.movies = movies
          completionHandler(.success(self.movies))
        case .failure(let error):
          //Handle error
          print(error)
          
        }
      }
  }
  
  func filterMovies(filter: String, completion: @escaping ([Movie]) -> Void ) {
    if filter.isEmpty {
      completion(movies)
      return
    }
     let movies = self.movies.filter { $0.title.contains(filter)}
    //Update model & view
    completion(movies)
   }
  
 
// MARK: -  Presenter <--> Repository
  func getMovies(completion: @escaping (Result<SuccessCode, Error>) -> Void) {
    movieFactory.getMovies { result in
       switch result {
           case .success(let movies):
            self.movies = movies
             completion(.success(.added))
           case .failure:
             print ("Error")
           }
    }
  
  }
  
}
