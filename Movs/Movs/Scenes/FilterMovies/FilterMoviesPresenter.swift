//
//  FilterMoviesPresenter.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FilterMoviesPresentationLogic {
  func presentFilterValues(response: FilterMovies.Response)
}

class FilterMoviesPresenter: FilterMoviesPresentationLogic {
  weak var viewController: FilterMoviesDisplayLogic?
  
  // MARK: Present Filter Values
  func presentFilterValues(response: FilterMovies.Response) {
    let viewModel = FilterMovies.ViewModel(genres: response.genres, dates: response.dates)
    viewController?.displayFilterValues(viewModel: viewModel)
  }
}
