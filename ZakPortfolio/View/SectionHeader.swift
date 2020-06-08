//
//  SectionHeader.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Zak Dillon. All rights reserved.
//

import UIKit

/// A generic section header
class SectionHeader: UICollectionReusableView {
	static let reuseIdentifier = "SectionHeader"	
	@IBOutlet weak var label: UILabel?
}
