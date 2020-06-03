//
//  iTunesResponse.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import Foundation

/// Represents a product feed from iTunes.
struct Feed: Codable {
	var results: [Movie]
}

struct FeedRoot: Codable {
	var feed: Feed
}
