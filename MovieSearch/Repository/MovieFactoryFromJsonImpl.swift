//
//  MovieFactoryFromJsonImpl.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

final class MovieFactoryFromJSONImpl : MovieFactory {
  
  func getMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
    // Read data from a local file
    guard let data = readLocalFile(forName: "omdbworld") else {
      print ("Error reading local file") //completion ¡handler error reading local file
      return
    }
    // Parse JSON data
    let decoder = JSONDecoder()
       do {
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
        
        // Code with delay from Network, CoreData, FileSystem... (Mock 2 seconds delay)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          completionHandler(.success(searchResponse.movies))
        }
        } catch {
          print(error)
          // Handle error completion
         //  completionHandler(.failure(error))
        }
    
    
  }
  
  private  func readLocalFile(forName name: String) -> Data? {
      do {
          if let bundlePath = Bundle.main.path(forResource: name,
                                               ofType: "json"),
              let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
              return jsonData
          }
      } catch {
          print(error)
      }
    
    return nil
  }
}
