//
//  FeaturedCell.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Zak Dillon. All rights reserved.
//

import UIKit

/// Displays a featured movie in the root view controller
class FeaturedCell: UICollectionViewCell, ImageCell {
	static let reuseIdentifier = "FeaturedCell"
	
	// Outlets
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var visualEffectView: UIVisualEffectView?
	@IBOutlet weak var shadowView: UIView?
	@IBOutlet weak var titleLabel: UILabel?

	/// The image for the movie.
	///
	/// Setting the image sets up any associated UI.
	var image: UIImage? {
		didSet {
			DispatchQueue.main.async {
				self.imageView?.image = self.image
			}
		}
	}
	
	override func prepareForReuse() {
		// Always call super!
		super.prepareForReuse()
		
		// Reset the cell
		image = nil
		titleLabel?.text = nil
	}
	
	override func layoutSubviews() {
		// Always call super!
		super.layoutSubviews()
		
		// Image View and visual effect view allow clipping for a corner radius.
		visualEffectView?.layer.cornerRadius = 8
		visualEffectView?.layer.masksToBounds = true
		imageView?.layer.cornerRadius = 8
		imageView?.layer.masksToBounds = true
		
		// Use shadow view to set up a nice drop shadow.
		shadowView?.layer.masksToBounds = false
		shadowView?.layer.shadowOffset = .zero
		shadowView?.layer.shadowRadius = 8
		shadowView?.layer.shadowColor = UIColor.black.cgColor
		shadowView?.layer.shadowOpacity = 1.0
	}
}
