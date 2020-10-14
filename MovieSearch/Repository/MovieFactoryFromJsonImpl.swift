//
//  MovieFactoryFromJsonImpl.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation


final class MovieFactoryFromJSONImpl : MovieFactory {
  
  func getMovies(completionHandler: @escaping (Result<[Movie], MovieError>) -> Void) {
    
    // 2 - Read data from a local file
    guard let data = readLocalFile(forName: "omdbworl") else {
      completionHandler(.failure(MovieError.readingError))
      return
    }
    
    // 3 - Parse JSON data
    let decoder = JSONDecoder()
    do {
      let searchResponse = try decoder.decode(SearchResponse.self, from: data)
      
      // Code with delay from Network, CoreData, FileSystem... (Mock 2 seconds delay)
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completionHandler(.success(searchResponse.movies))
      }
    } catch {
      completionHandler(.failure(MovieError.decodingError))
    }
    
    
    
  }
  
  // 1 - Throws error reading from local file
  private  func readLocalFile(forName name: String) -> Data?  {
    if let bundlePath = Bundle.main.path(forResource: name,
                                         ofType: "json"),
       let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
      return jsonData
    } else {
      return nil
    }
  }
}

