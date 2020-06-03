//
//  MovieCell.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import UIKit

protocol ImageCell: UICollectionViewCell {
	var image: UIImage? { get set }
}

/// The standard cell used in the root view controller to represent a movie.
class MovieCell: UICollectionViewCell, ImageCell {
	static let reuseIdentifier = "MovieCell"
	
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var artistLabel: UILabel?
	
	var image: UIImage? {
		didSet {
			DispatchQueue.main.async {
				self.imageView?.image = self.image
			}
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		image = nil
		titleLabel?.text = nil
		artistLabel?.text = nil
	}
}
