//
//  MovieDetailsInteractor.swift
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

protocol MovieDetailsBusinessLogic {
  func fetchMovieDetails(request: Movies.Details.Request)
  func saveFavoriteMovie()
  func isFavoriteMovie()
}

protocol MovieDetailsDataStore {
  var movie: Movie! { get set }
  var genres: [Genre]! { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
  var presenter: MovieDetailsPresentationLogic?
  var worker: MovieDetailsWorker?
  
  var movie: Movie!
  var genres: [Genre]!
  
  
  // MARK: Fetch Movies Details
  func fetchMovieDetails(request: Movies.Details.Request) {
    let response = Movies.Details.Response(movie: movie, genres: genres)
    presenter?.presentMovieDetails(response: response)
  }
  
  // MARK: Favor Movie
  func saveFavoriteMovie() {
    worker = MovieDetailsWorker()
    let request = Movies.Details.Request(movie: movie, genres: genres)
    worker?.saveFavoriteMovie(request: request)
    movie.isFavorite = true
  }
  
  func isFavoriteMovie() {
    worker = MovieDetailsWorker()
    let request = Movies.Details.Request(movie: movie, genres: genres)
    if worker!.isFavoriteMovie(request: request) {
      let response = Movies.Details.Response(movie: request.movie!, genres: request.genres!)
      presenter?.presentFavoriteMovie(response: response)
    }
  }
}
