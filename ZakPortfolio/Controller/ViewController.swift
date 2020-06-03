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
	var dataSource: UICollectionViewDiffableDataSource<Section, [Movie]>! = nil
	
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
		dataSource = UICollectionViewDiffableDataSource<Section, [Movie]>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movies: [Movie]) -> UICollectionViewCell? in
			
			// What section are we look at?
			let section = Section.allCases[indexPath.section]
			
			switch section {
				case .featured:
					// Create the cell
					let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseIdentifier, for: indexPath) as? FeaturedCell
					
					// Grab a reference to the movie
					let movie = movies[indexPath.item]

					// TODO: Set up the cell
					

					// Return the Cell
					return cell
				default:
					// Create the cell
					let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
					
					// Grab a reference to the movie
					let movie = movies[indexPath.item]
					
					// TODO: Set up the cell
					cell?.titleLabel?.text = movie.name
					cell?.artistLabel?.text = movie.artistName
					
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

	/// Creates a snapshot to be applied to the UIDiffableDataSource
	fileprivate func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, [Movie]> {
		// Create the snapshot
		var snapshot = NSDiffableDataSourceSnapshot<Section, [Movie]>()
		
		// Append sections...
		
		snapshot.appendSections([Section.featured])
		snapshot.appendItems([service.featured])
		
		snapshot.appendSections([Section.popular])
		snapshot.appendItems([service.popular])
		
		snapshot.appendSections([Section.new])
		snapshot.appendItems([service.new])

		snapshot.appendSections([Section.group1])
		snapshot.appendItems([service.group1])

		snapshot.appendSections([Section.group2])
		snapshot.appendItems([service.group2])
		
		snapshot.appendSections([Section.group3])
		snapshot.appendItems([service.group3])
		
		snapshot.appendSections([Section.group4])
		snapshot.appendItems([service.group4])
		
		snapshot.appendSections([Section.group5])
		snapshot.appendItems([service.group5])
		
		snapshot.appendSections([Section.group6])
		snapshot.appendItems([service.group6])
		
		snapshot.appendSections([Section.group7])
		snapshot.appendItems([service.group7])
		
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
											  heightDimension: .fractionalWidth(2/3))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		// Show one item plus a small peek of the next item
		let groupFractionalWidth: CGFloat = 0.95
		let groupFractionalHeight: CGFloat = 2/3
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth),
											   heightDimension: .fractionalWidth(groupFractionalHeight))
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
		group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

		// Create and set up the header

		// The header should be 1/4 the vertical size of the view, and go all the way across.
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												heightDimension: .fractionalHeight(1/4))
		
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: FeaturedSectionHeader.reuseIdentifier, alignment: .top)
		
		let section = NSCollectionLayoutSection(group: group)
		section.boundarySupplementaryItems = [sectionHeader]
		section.orthogonalScrollingBehavior = .groupPaging
		
		return section
	}
	
	// Generates
	func generateMovieSectionLayout() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalWidth(2/3))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		// Show one item plus peek on narrow screens, two items plus peek on wider screens
		let groupFractionalWidth: CGFloat = 0.95
		let groupFractionalHeight: CGFloat = 2/3
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(groupFractionalWidth),
			heightDimension: .fractionalWidth(groupFractionalHeight))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
		group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		// Set up the header
		
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												heightDimension: .estimated(50))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: SectionHeader.reuseIdentifier, alignment: .top)
		
		let section = NSCollectionLayoutSection(group: group)
		section.boundarySupplementaryItems = [sectionHeader]
		section.orthogonalScrollingBehavior = .groupPaging
		
		return section
	}


}

