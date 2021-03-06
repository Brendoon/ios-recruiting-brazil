//
//  FavoriteMoviesViewController.swift
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

protocol FavoriteMoviesDisplayLogic: class {
  func displayFavoriteMovies(viewModel: FavoriteMovies.Show.ViewModel)
  func displayErrorMessage(viewModel: FavoriteMovies.Show.ViewModel)
}

class FavoriteMoviesViewController: UIViewController {
  var interactor: FavoriteMoviesBusinessLogic?
  var router: (NSObjectProtocol & FavoriteMoviesRoutingLogic & FavoriteMoviesDataPassing)?
  
  let favoriteMoviesView = FavoriteMoviesView()
  var isFiltering = false

  // MARK: Object lifecycle
  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Favorites"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonPressed))
    self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(named: self.title!.lowercased()), tag: 0)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  private func setup() {
    let viewController = self
    let interactor = FavoriteMoviesInteractor()
    let presenter = FavoriteMoviesPresenter()
    let router = FavoriteMoviesRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if !isFiltering {
      DispatchQueue.main.async {
        self.fetchFavoriteMovies()
      }
    }
  }
  
  override func loadView() {
    self.view = favoriteMoviesView
  }
  
  func setupTableView() {
    favoriteMoviesView.tableView.setDeletionHandler(deleteFavoriteMovie)
    favoriteMoviesView.tableView.headerButton.addTarget(self, action: #selector(removeFilter), for: .touchUpInside)
  }
  
  @objc func filterButtonPressed() {
    router?.routeToFilterMovies()
  }
  
  // MARK: Fetch Favorite Movies
  func fetchFavoriteMovies(_ query: String? = .none, isFiltering: Bool = false) {
    let request = FavoriteMovies.Show.Request(query: query, isFiltering: isFiltering)
    interactor?.fetchFavoriteMovies(request: request)
  }
  
  // MARK: Delete Favorite Movie
  func deleteFavoriteMovie(_ movie: CDMovie) {
    let request = FavoriteMovies.Delete.Request(movie: movie, isFiltering: isFiltering)
    interactor?.unfavoriteMovie(request: request)
  }
  
  // MARK: Fetch Favorite Movies for a genre and/or date
  func fetchFavoriteMovies(for date: String, genre: String) {
    isFiltering = true
    favoriteMoviesView.tableView.showHeader()
    let request = FavoriteMovies.Filter.Request(date: date, genre: genre)
    interactor?.applyFilter(request: request)
  }
  
  // MARK: Fetch Local and/or Filtered Movies
  func fetchLocalMovies() {
    let request = FavoriteMovies.Show.Request(isFiltering: isFiltering)
    interactor?.fetchLocalMovies(request: request)
  }
  
  @objc func removeFilter() {
    isFiltering = false
    favoriteMoviesView.tableView.hideHeader()
    fetchFavoriteMovies()
  }
}

extension FavoriteMoviesViewController: FavoriteMoviesDisplayLogic {
  func displayFavoriteMovies(viewModel: FavoriteMovies.Show.ViewModel) {
    favoriteMoviesView.errorView.setup(with: .none)
    favoriteMoviesView.tableView.updateItems(viewModel.movies)
    favoriteMoviesView.isUserInteractionEnabled = true
  }
  
  func displayErrorMessage(viewModel: FavoriteMovies.Show.ViewModel) {
    favoriteMoviesView.tableView.updateItems(viewModel.movies)
    favoriteMoviesView.errorView.setup(with: viewModel.error)
    favoriteMoviesView.isUserInteractionEnabled = false
  }
}

// MARK: - UISearchBarDelegate
extension FavoriteMoviesViewController: UISearchBarDelegate {
  
  func setupSearchBar(){
    self.definesPresentationContext = true
    let searchController = UISearchController(searchResultsController: nil)
    searchController.definesPresentationContext = true
    searchController.searchBar.delegate = self
    searchController.searchBar.tintColor = ColorPalette.black
    searchController.dimsBackgroundDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    self.navigationItem.searchController = searchController
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if !searchText.isEmpty {
      fetchFavoriteMovies(searchText, isFiltering: isFiltering)
    } else {
      fetchLocalMovies()
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    fetchLocalMovies()
  }
}
