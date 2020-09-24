//
//  MoviesPresenter.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

typealias Update = () -> Void

protocol MoviesPresenter: class {
  // Presenter Owner <--> Presenter
  func moviesToShow(completionHandler: @escaping (Result<[Movie], Error>) -> Void)
  func filterMovies(filter: String, completion: @escaping ([Movie]) -> Void )
  
  // Presenter <--> Repository
  func getMovies(completion: @escaping (Result<SuccessCode, Error>) -> Void)

}
