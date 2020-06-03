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
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}
