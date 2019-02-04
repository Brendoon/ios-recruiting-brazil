//
//  MovieDetailsPresenter.swift
//  Movs
//
//  Created by Brendoon Ryos on 31/01/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsPresentationLogic {
  func presentMovieDetails(response: Movies.Details.Response)
  func presentFavoriteMovie(response: Movies.Details.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {
  weak var viewController: MovieDetailsDisplayLogic?
  
  // MARK: Present Movie Details
  func presentMovieDetails(response: Movies.Details.Response) {
    let viewModel = Movies.Details.ViewModel(movie: response.movie, genres: response.genres)
    viewController?.displayMovieDetails(viewModel: viewModel)
  }
  
  // MARK: Present Favorite Movie
  func presentFavoriteMovie(response: Movies.Details.Response) {
    let viewModel = Movies.Details.ViewModel(movie: response.movie, genres: response.genres)
    viewController?.displayFavoriteMovie(viewModel: viewModel)
  }
}