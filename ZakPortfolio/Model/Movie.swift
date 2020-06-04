//
//  Movie.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import Foundation

/// Represents a Movie object returned from iTunes. 
struct Movie: Codable, Hashable {	
	var name: String
	var artistName: String
	var artworkUrl100: String
}
