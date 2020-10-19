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

		let moviesData = try parseSearchJSON(path: "Search", data: data)

        let searchedMovies = try decoder.decode([Movie].self, from: moviesData)
        
        // Code with delay from Network, CoreData, FileSystem... (Mock 2 seconds delay)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          completionHandler(.success(searchedMovies))
        }
        } catch {
          print(error)
          // Handle error completion
         //  completionHandler(.failure(error))
        }
    
    
  }

	func parseSearchJSON(path: String, data: Data) throws -> Data {
		let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
		let moviesArray = json[path] as! [[String: Any]]
		let moviesData = try JSONSerialization.data(withJSONObject: moviesArray, options: [])

		return moviesData
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
