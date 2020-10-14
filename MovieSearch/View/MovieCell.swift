//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
  
  static let id = "movieCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
  
  override func layoutSubviews() {
    super .layoutSubviews()
    
    // Content View
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    
    
    let aspectRatio: CGFloat = 0.6
    let aspectRatioConstraint =
          imageView?.widthAnchor.constraint(
            equalTo: imageView!.heightAnchor,
            multiplier: aspectRatio)
      aspectRatioConstraint?.isActive = true

    
  }
  
}
