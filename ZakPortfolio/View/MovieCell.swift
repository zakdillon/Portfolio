//
//  MovieCell.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import UIKit

/// The standard cell used in the root view controller to represent a movie.
class MovieCell: UICollectionViewCell {
	static let reuseIdentifier = "MovieCell"
	
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var artistLabel: UILabel?
}
