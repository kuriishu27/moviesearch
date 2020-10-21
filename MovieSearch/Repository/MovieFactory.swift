//
//  MovieFactory.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

enum MovieError: Error {
  // Reading from local file
  case readingError
  // API errors
  case decodingError
  case invalidAPIkey
  case wrongID
  case movieNotfound
  case unknow
  
  // API Errors
  // Invalid API key!
  // No API key provided
  // Incorrect IMDb ID.
  // Movie not found!
}
// Custom descriptions here
extension MovieError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .readingError:
      return NSLocalizedString("We can't read from local file", comment: "We can't read from local file")
    case .decodingError:
      return NSLocalizedString("Error decoding file", comment: "Error decoding file")
    case .invalidAPIkey:
      return NSLocalizedString("Authentication fail", comment: "Authentication fail")
    case .wrongID:
      return NSLocalizedString("Movie not found with that identifier", comment: "Movie not found with that identifier")
    case .movieNotfound:
      return NSLocalizedString("Movie not found", comment: "movie not found")
    case .unknow:
      return NSLocalizedString("Unknow error", comment: "Unknow error")
    }
  }
  
}
enum SuccessCode: String {
  case added = "OK. Movie was added"
  case updated = "OK. Movie was updated"
  case delete = "OK. Movie was deleted"
}

protocol MovieFactory {
//  Input
  func getMovies(completionHandler: @escaping (Result<[Movie], MovieError>) -> Void)

// Update

}
