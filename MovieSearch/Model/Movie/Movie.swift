//
//  Movie.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

public class Movie: Decodable {
	let title: String
	let year: String
	let imageURL: String

	private enum CodingKeys: String, CodingKey {
		case title = "Title"
		case poster = "Poster"
		case year = "Year"
	}
	
	init(title: String, year: String, imageURL: String) {
		self.title = title
		self.year = year
		self.imageURL = imageURL
	}
}

