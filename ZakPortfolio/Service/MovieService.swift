//
//  MovieService.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import Foundation

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
				if i < 10 {
					featured.append(movies[i])
				} else if i < 20 {
					popular.append(movies[i])
				} else if i < 30 {
					new.append(movies[i])
				} else if i < 40 {
					group1.append(movies[i])
				} else if i < 50 {
					group2.append(movies[i])
				} else if i < 60 {
					group3.append(movies[i])
				} else if i < 70 {
					group4.append(movies[i])
				} else if i < 80 {
					group5.append(movies[i])
				} else if i < 90 {
					group6.append(movies[i])
				} else if i < 100 {
					group7.append(movies[i])
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
	var group4: [Movie] = []
	var group5: [Movie] = []
	var group6: [Movie] = []
	var group7: [Movie] = []
		
	/// Loads the top 100 movies from itunes.
	func loadData(completion: @escaping (() -> ())) {
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
				// TODO: error handling... bubble up to UI?
				return
			}
			
			do {
				// Parse the data
				let feedRoot = try JSONDecoder().decode(FeedRoot.self, from: json)

				// Set our movie values
				self.movies = feedRoot.feed.results
				
				completion()

			} catch {
				completion()
				return
			}
		}.resume()
	}
}
