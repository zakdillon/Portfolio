//
//  FeaturedSectionHeader.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import UIKit

/// The Featured Section Header provides a little visual glitz to the top section.
class FeaturedSectionHeader: UICollectionReusableView {
	static let reuseIdentifier = "FeaturedSectionHeader"
	
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var label: UILabel?

	override func layoutSubviews() {
		// Always call super!
		super.layoutSubviews()
		
		// Give a "swoop" to the bottom left corner
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 120
		self.layer.maskedCorners = [.layerMinXMaxYCorner]
		
		// Give the label a bit of a shadow
		label?.layer.masksToBounds = false
		label?.layer.shadowOffset = .zero
		label?.layer.shadowRadius = 8
		label?.layer.shadowColor = UIColor.black.cgColor
		label?.layer.shadowOpacity = 0.5
	}
}
