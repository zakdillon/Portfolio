//
//  ViewController.swift
//  ZakPortfolio
//
//  Created by Zachary Dillon on 6/3/20.
//  Copyright © 2020 Midwest Tape, LLC. All rights reserved.
//

import UIKit

/// The Root View Controller of the application.
class ViewController: UIViewController {

	var collectionView: UICollectionView?

	/// The service that fetches all data for the view
	let service = MovieService()
	
	/// The Section Enumeration
	///
	/// Cases for featured, popular, and new.
	/// Addtional cases for more groups to showcase a more diverse set of data
	enum Section: String, CaseIterable {
		case featured = "Featured"
		case popular = "Popular"
		case new = "New Releases"
		case group1 = "Group 1"
		case group2 = "Group 2"
		case group3 = "Group 3"
		case group4 = "Group 4"
		case group5 = "Group 5"
		case group6 = "Group 6"
		case group7 = "Group 7"
	}
	
	/// Affords us the ability to use UICollectionViewDiffableDataSource and a compositional layout
	var dataSource: UICollectionViewDiffableDataSource<Section, Movie>! = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
				
		// Set up the collection view.
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
		view.addSubview(collectionView!)
		collectionView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		collectionView?.backgroundColor = .systemBackground
		
		// Register for cells
		collectionView?.register(UINib(nibName: FeaturedCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
		collectionView?.register(UINib(nibName: MovieCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.reuseIdentifier)

		// Register for reusable views
		collectionView?.register(UINib(nibName: FeaturedSectionHeader.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: FeaturedSectionHeader.reuseIdentifier, withReuseIdentifier: FeaturedSectionHeader.reuseIdentifier)
		collectionView?.register(UINib(nibName: SectionHeader.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: SectionHeader.reuseIdentifier, withReuseIdentifier: SectionHeader.reuseIdentifier)
		
		// Set up the data source
		configureDataSource()
		
		// Fetch the data
		service.loadData {
			let snapshot = self.snapshotForCurrentState()
			self.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
	
	
	/// Sets up the diffable data source
	func configureDataSource() {
		// Make sure we have a collection view
		guard let collectionView = collectionView else { return }
		
		// Configure the datasource for the collection view
		dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie: Movie) -> UICollectionViewCell? in
			
			// What section are we look at?
			let section = Section.allCases[indexPath.section]
			
			switch section {
				case .featured:
					// Create the cell
					let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseIdentifier, for: indexPath) as? FeaturedCell
					
					// Fetch the image
					if let url = URL(string: movie.artworkUrl100), cell != nil {
						self.fetchImage(at: url, for: cell!)
					}
					
					// Set up the label
					cell?.titleLabel?.text = movie.name

					// Return the Cell
					return cell
				default:
					// Create the cell
					let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
										
					// Set up the text labels
					cell?.titleLabel?.text = movie.name
					cell?.artistLabel?.text = movie.artistName
					
					// Fetch the image
					if let url = URL(string: movie.artworkUrl100), cell != nil {
						self.fetchImage(at: url, for: cell!)
					}
					
					// Return the cell
					return cell
			}
		})
		
		dataSource.supplementaryViewProvider = {
			(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
			
			// What section are we look at?
			let section = Section.allCases[indexPath.section]
			
			switch section {
				case .featured:
					// Get the header
					let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FeaturedSectionHeader.reuseIdentifier, for: indexPath) as? FeaturedSectionHeader
				
					// TODO: configure header
					
					// Return it
					return header
				
				default:
					// Get the header
					let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
					
					// Set the label text
					header?.label?.text = section.rawValue
				
					// Return it
					return header
			}

		}
		
		// Create and apply the snapshot
		let snapshot = snapshotForCurrentState()
		dataSource.apply(snapshot, animatingDifferences: false)
	}
	
	/// Fetches the image and sets it on the cell.
	fileprivate func fetchImage(at url: URL, for cell: ImageCell) {
		URLSession.shared.dataTask(with: url) { [cell] (data, response, error) in
			// Make sure we didnt get an error
			guard error == nil else { return }
			
			// Make sure we got data back
			guard let imageData = data else { return }
			
			// Turn that data into an image
			cell.image = UIImage(data: imageData)
		}.resume()
	}

	/// Creates a snapshot to be applied to the UIDiffableDataSource
	fileprivate func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, Movie> {
		// Create the snapshot
		var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
		
		// Append sections...
		
		snapshot.appendSections([Section.featured])
		snapshot.appendItems(service.featured)
		
		snapshot.appendSections([Section.popular])
		snapshot.appendItems(service.popular)
		
		snapshot.appendSections([Section.new])
		snapshot.appendItems(service.new)

		snapshot.appendSections([Section.group1])
		snapshot.appendItems(service.group1)

		snapshot.appendSections([Section.group2])
		snapshot.appendItems(service.group2)
		
		snapshot.appendSections([Section.group3])
		snapshot.appendItems(service.group3)
		
		snapshot.appendSections([Section.group4])
		snapshot.appendItems(service.group4)
		
		snapshot.appendSections([Section.group5])
		snapshot.appendItems(service.group5)
		
		snapshot.appendSections([Section.group6])
		snapshot.appendItems(service.group6)
		
		snapshot.appendSections([Section.group7])
		snapshot.appendItems(service.group7)
		
		// Return the snapshot
		return snapshot
	}

	/// Generates a UICollectionViewCompositionalLayout
	func generateLayout() -> UICollectionViewLayout {
		// Create the layout
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
			layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

			// What section are we setting up?
			let section = Section.allCases[sectionIndex]
			switch section {
				case .featured: return self.generateFeaturedSectionLayout()
				default: return self.generateMovieSectionLayout()
			}
		}
		
		// Return the layout
		return layout
	}

	/// Creates a featured Layout section
	func generateFeaturedSectionLayout() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)

		// Show one item plus a small peek of the next item
		let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
											   heightDimension: .absolute(150))
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
		group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(20), top: .fixed(8), trailing: .fixed(0), bottom: .fixed(8))

		// Create and set up the header

		// The header should be 1/4 the vertical size of the view, and go all the way across.
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												heightDimension: .fractionalHeight(1/4))
		
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: FeaturedSectionHeader.reuseIdentifier, alignment: .top)
		
		let section = NSCollectionLayoutSection(group: group)
		section.boundarySupplementaryItems = [sectionHeader]
		section.orthogonalScrollingBehavior = .continuous

		return section
	}
	
	// Generates
	func generateMovieSectionLayout() -> NSCollectionLayoutSection {
		// Create the item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		// Add the item ot a group
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .absolute(133),
			heightDimension: .estimated(248))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
		
		// Set up the header
		
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												heightDimension: .absolute(50))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: SectionHeader.reuseIdentifier, alignment: .top)
		
		// Add the group and header to a section
		let section = NSCollectionLayoutSection(group: group)
		section.boundarySupplementaryItems = [sectionHeader]
		section.orthogonalScrollingBehavior = .continuous
		section.interGroupSpacing = 20.0
		section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
		
		// Return the section
		return section
	}
}
