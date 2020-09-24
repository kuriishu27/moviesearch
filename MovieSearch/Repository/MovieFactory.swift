//
//  MovieFactory.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

enum MovieFactoryError: Error {
  // Define errors
}
enum SuccessCode: String {
  case added = "OK. Contact was added"
  case updated = "OK. Contact was updated"
  case delete = "OK. Contact was deleted"
}

protocol MovieFactory {
//  Input
  func getMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) 

// Update

}
