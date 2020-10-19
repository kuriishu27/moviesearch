//
//  SearchRespponse.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

struct SearchResponse : Decodable {
  let movies: [Movie]
  
  private enum CodingKeys: String, CodingKey {
    case search = "Search"
    
    enum DataKeys: String, CodingKey {
      case title = "Title"
      case poster = "Poster"
      case year = "Year"
    }
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    var dataContainer = try container.nestedUnkeyedContainer(forKey: .search)
    
    var decodedMovies: [Movie] = []
    
    while !dataContainer.isAtEnd {
      let searchEntry = try dataContainer.nestedContainer(keyedBy: CodingKeys.DataKeys.self)
      let title = try searchEntry.decode(String.self,  forKey: .title)
      let poster = try searchEntry.decode(String.self,  forKey: .poster)
      let year = try searchEntry.decode(String.self,  forKey: .year)
      
      let movie = Movie(title: title, year: year, imageURL: poster)
      
      decodedMovies.append(movie)
    }
    
    movies = decodedMovies
  }
  
}
