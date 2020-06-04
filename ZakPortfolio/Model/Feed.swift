//
//  iTunesResponse.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import Foundation

/// The root of the iTunes RSS.
///
/// The RSS from iTunes has a "containter" object that the feed resides in.
struct FeedRoot: Codable {
	var feed: Feed
}

/// Represents a product feed from iTunes.
///
/// The feed item contains more information, but none that is necessary to this app.
struct Feed: Codable {
	var results: [Movie]
}
