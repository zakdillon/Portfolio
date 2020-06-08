//
//  MovieCell.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Zak Dillon. All rights reserved.
//

import UIKit

protocol ImageCell: UICollectionViewCell {
	var image: UIImage? { get set }
}

/// The standard cell used in the root view controller to represent a movie.
class MovieCell: UICollectionViewCell, ImageCell {
	// Reuse
	static let reuseIdentifier = "MovieCell"

	// Outlets
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var shadowView: UIView?
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var artistLabel: UILabel?
	
	/// The image for the movie.
	///
	/// Setting the image sets up any associated UI.
	var image: UIImage? {
		didSet {
			// We dont know where image will be set from. Be sure to set up the UI
			// on the main thread.
			DispatchQueue.main.async {
				// Set the image on the image view
				self.imageView?.image = self.image
				
				// Animate the image coming in.
				let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
					self.imageView?.alpha = 1.0
					self.shadowView?.alpha = 1.0
				}
				animator.startAnimation()
				
				// If the image is nil, hide the shadow view to avoid pop in
				self.shadowView?.isHidden = self.image == nil ? true : false
			}
		}
	}
	
	override func prepareForReuse() {
		// Always call super!
		super.prepareForReuse()
		
		// Reset the cell
		image = nil
		imageView?.alpha = 0
		shadowView?.alpha = 0
		titleLabel?.text = nil
		artistLabel?.text = nil
	}
	
	override func layoutSubviews() {
		// Always call super!
		super.layoutSubviews()
		
		// Allow the image view to clip, and give it corners
		imageView?.layer.cornerRadius = 8
		imageView?.layer.masksToBounds = true
		imageView?.layer.borderColor = UIColor.tertiaryLabel.cgColor
		imageView?.layer.borderWidth = 1.0
		
		// Use the designated shadow view to create a drop shadow
		shadowView?.layer.masksToBounds = false
		shadowView?.layer.shadowOffset = .zero
		shadowView?.layer.shadowRadius = 12
		shadowView?.layer.shadowColor = UIColor.black.cgColor
		shadowView?.layer.shadowOpacity = 1.0
	}
}
