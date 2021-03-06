//
//  FavoriteMoviesRouter.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol FavoriteMoviesRoutingLogic {
  func routeToFilterMovies()
}

protocol FavoriteMoviesDataPassing {
  var dataStore: FavoriteMoviesDataStore? { get }
}

class FavoriteMoviesRouter: NSObject, FavoriteMoviesRoutingLogic, FavoriteMoviesDataPassing {
  weak var viewController: FavoriteMoviesViewController?
  var dataStore: FavoriteMoviesDataStore?
  
  // MARK: Routing
  func routeToFilterMovies() {
    let destinationVC = FilterMoviesViewController()
    var destinationDS = destinationVC.router!.dataStore!
    
    destinationVC.applyFilter = viewController?.fetchFavoriteMovies
    passDataToFilterMovies(source: dataStore!, destination: &destinationDS)
    navigateToFilterMovies(source: viewController!, destination: destinationVC)
  }

  // MARK: Navigation
  func navigateToFilterMovies(source: FavoriteMoviesViewController, destination: FilterMoviesViewController) {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  func passDataToFilterMovies(source: FavoriteMoviesDataStore, destination: inout FilterMoviesDataStore) {
    destination.dates = source.dates
    destination.genres = source.genres
  }
}
