//
//  FeaturedCell.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import UIKit

/// Displays a featured movie in the root view controller
class FeaturedCell: UICollectionViewCell, ImageCell {
	static let reuseIdentifier = "FeaturedCell"
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var titleLabel: UILabel?

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
	}
}
