//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
  

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var year: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
  }
  
}
