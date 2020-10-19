//
//  Extension+Equatable].swift
//  MovieSearch
//
//  Created by Christian Leovido on 16/10/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import Foundation

extension Movie: Equatable {
	public static func == (lhs: Movie, rhs: Movie) -> Bool {
		return lhs.title == rhs.title &&
			lhs.year == rhs.year &&
			lhs.imageURL == rhs.imageURL
	}
}
