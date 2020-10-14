//
//  MovieFactoryAPI.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 06/10/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

// Request example
// https://www.omdbapi.com/?apikey=22f99487&s=world

enum MovieAPI {
  static let URL_BASE = URL(string: "https://www.omdbapi.com/")!
  static let API_KEY = "22f99487"
}

enum MovieOptions {
  
}

final class MovieFactoryFromAPI: MovieFactory {
  
  let session = URLSession.shared
  let url = MovieAPI.URL_BASE
  var task: URLSessionDataTask?
  
  func getMovies(completionHandler: @escaping (Result<[Movie], MovieError>) -> Void) {
    
    // 1. Add URLComponents
    var components = URLComponents(string: url.absoluteString)
    components?.queryItems = [URLQueryItem(name: "s", value: "world"),
                              URLQueryItem(name: "apikey", value: MovieAPI.API_KEY)]
    
    // 2. Create URLRequest - Headers need to be set with Authorization
    let request = URLRequest(url: components!.url!)
    
    
    // 3. Add task cancel to avoid multiple requests
    task?.cancel()
    
    task = session.dataTask(with: request) { (data, response, error) in
      
      if let error = error {
        print(error.localizedDescription)
        fatalError()
      }
      
      guard let response = response as? HTTPURLResponse else {
        return
      }
      
      let status = response.statusCode
      guard (200...299).contains(status) else {
        print(response.description)
        return
      }
      
      guard let data = data else {
        fatalError()
      }
      
      // 3.4. Create a JSON object from the data received from the network
      let decoder = JSONDecoder()
      do {
        let searchResponse = try decoder.decode(SearchResponse.self, from: data)
            
          completionHandler(.success(searchResponse.movies))
        
      } catch {
        completionHandler(.failure(MovieError.decodingError))
      }
      
    }
    task?.resume()
    // 4. Run the networking request after everything is configured.
    
  }
  
  
}
