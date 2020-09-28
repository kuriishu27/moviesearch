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

class ExampleMovieCell: UITableViewCell {

	let titleLabel: UILabel = {

		let label = UILabel()

		// customize your label here..
		label.backgroundColor = .red

		return label

	}()

	let poster: UIImageView = {
		return UIImageView()
	}()

	let year: UILabel = {
		return UILabel()
	}()

	override func awakeFromNib() {
		super.awakeFromNib()

		let stackView = UIStackView(arrangedSubviews: [titleLabel,
													   poster,
													   year])

		stackView.axis = .vertical
		stackView.spacing = 5
		stackView.distribution = .fillEqually

		addSubview(stackView)

	}

}
