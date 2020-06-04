//
//  MovieService.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import Foundation

/// Used to fetch movies from iTunes.
class MovieService {
	/// All the movies returned by iTunes.
	///
	/// When we get new movies from apple, break them up into groups of 10 to replicate a "real" web service call.
	/// These groups of 10 are completely arbitrary.
	private var movies: [Movie] = [] {
		didSet {
			// Rather than be "fancy" and use array slicing, lets make sure we never run over our data
			// in case iTunes returns less than 100 titles.
			var i = 0
			while i < movies.count {
				if i < 5 {
					featured.append(movies[i])
				} else if i < 25 {
					popular.append(movies[i])
				} else if i < 45 {
					new.append(movies[i])
				} else if i < 65 {
					group1.append(movies[i])
				} else if i < 85 {
					group2.append(movies[i])
				} else if i < 100 {
					group3.append(movies[i])
				}
				
				// Incremnt
				i+=1
			}
		}
	}
	
	var featured: [Movie] = []
	var popular: [Movie] = []
	var new: [Movie] = []
	var group1: [Movie] = []
	var group2: [Movie] = []
	var group3: [Movie] = []
		
	/// Loads the top 100 movies from itunes.
	func loadData(completion: @escaping ((_ success: Bool) -> ())) {
		guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/100/explicit.json") else { return }
		
		// Create a request. Use cached data if we can. If not, this should not take longer than 30 seconds.
		// If a request to apple takes longer than 30 seconds, we can assume somethign went wrong.
		let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
		
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			// Make sure of the following:
			// 1. No error occurred
			// 2. We got a 200 status code back from the server
			// 3. We got JSON data back.
			guard
				error == nil,
				let httpResponse = response as? HTTPURLResponse,
				httpResponse.statusCode == 200,
				let json = data
			else {
				completion(false)
				return
			}
			
			do {
				// Parse the data
				let feedRoot = try JSONDecoder().decode(FeedRoot.self, from: json)

				// Set our movie values
				self.movies = feedRoot.feed.results
				
				// Call completion
				completion(true)

			} catch {
				completion(false)
				return
			}
		}.resume()
	}
}
