//
//  ViewController.swift
//  MovieSearch
//
//  Created by Pedro Sakey on 24/09/2020.
//  Copyright © 2020 pedrosakey.com. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
  
  // MARK: - Var & Constants
  let movieFactory: MovieFactory
  let moviePresenter: MoviesPresenter
  var movies: [Movie] {
    didSet {
      updateTableView()
    }
  }
  
  var tableView: UITableView!
  var searchBar: UISearchBar!
  var safeArea: UILayoutGuide!
  
  init() {
        self.movies = []
    //    self.movieFactory = MovieFactoryFromJSONImpl()
        self.movieFactory = MovieFactoryFromAPI()
        self.moviePresenter = MoviesPresenterImpl(movieFactory)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  // MARK: - LifeCycle methods
  
  override func loadView() {
    super.loadView()
    safeArea = view.layoutMarginsGuide
  }
  
  override func viewDidLoad(){
    super.viewDidLoad()
    // 1. Set Views: Table Views and SearchBar
    tableView = UITableView()
    searchBar = UISearchBar()
    
    // 2. Register a custom UITableViewCell

    
    // 6. Set the delegate and dataSource to self
    tableView.dataSource = self
    searchBar.delegate = self
    
    // 2. Set up Views, UI
    setupSearchBar()
    setupTableView()
//    tableView.rowHeight = 180
    
    
    
    
    startSpinner()
    
    DispatchQueue.global().async {
      self.moviePresenter.moviesToShow { result in
        switch result {
        case .success(let movies):
          DispatchQueue.main.async {
          self.movies = movies
          self.stopSpinner()
          }
        case .failure (let error):
          DispatchQueue.main.async {
            self.stopSpinner()
            self.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
          }
        }
      }
    }
    
  }
  
  // MARK: - Functions
  
  func setupSearchBar() {
    
    view.addSubview(searchBar)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  }
  
  func setupTableView() {
    
    // 2. Register a custom UITableViewCell
    tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.id)

    
    tableView.dataSource = self
    
    // Height is 20% of the view
    tableView.rowHeight = view.frame.height * 0.2
    

    // 3. add the tableView to the subView
    view.addSubview(tableView)
    
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
    tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.id)

  }
  
  func updateTableView() {
    tableView.reloadData()
  }
  
  func startSpinner() {
    let child = SpinnerViewController()
    
    addChild(child)
    child.view.frame = view.frame
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
  
  func stopSpinner() {
    let child = self.children[0]
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
  }
  
  
}

// MARK: - TableView Datasource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id,
                                             for: indexPath) as! MovieCell
    
    cell.textLabel?.text = movies[indexPath.row].title
    cell.detailTextLabel?.text = movies[indexPath.row].year
    if let url = URL(string: movies[indexPath.row].imageURL) {
      cell.imageView!.kf.setImage(with: url)
    }
    return cell
  }
  
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let textBefore = searchBar.text!
    var currentText : String {
      return (textBefore as NSString).replacingCharacters(in: range, with: text)
    }
    
    self.moviePresenter.filterMovies(filter: currentText) { movies in
      self.movies = movies
      self.updateTableView()
    }
    return true
    
  }
  
}

