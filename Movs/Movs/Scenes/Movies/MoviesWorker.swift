//
//  MoviesWorker.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MoviesWorker {
  private let networkManager: Networkable
  
  init(networkManager: Networkable = NetworkManager()) {
    self.networkManager = networkManager
  }
  
  func fetchMovies(request: Movies.Popular.Request, completion: @escaping (Result<MoviesData>) -> ()) {
    networkManager.fetchMovies(request: request) { result in
      completion(result)
    }
  }
  
  func fetchGenres(completion: @escaping (Result<GenresData>) -> ()) {
    networkManager.fetchGenres() { result in
      completion(result)
    }
  }
}