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
  private let movieFactory: MovieFactory
  private let moviePresenter: MoviesPresenter
  var movies: [Movie] {
    didSet {
      updateTableView()
    }
  }
  
  // MARK: - Init / Assembly
  required init?(coder: NSCoder) {
    self.movies = []
    self.movieFactory = MovieFactoryFromJSONImpl()
    self.moviePresenter = MoviesPresenterImpl(movieFactory)
    super.init(coder: coder)
  }
  
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - LifeCycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    searchBar.delegate = self
    
    // UI
    tableView.rowHeight = 180
    startSpinner()
    
    DispatchQueue.global().async {
      self.moviePresenter.moviesToShow { result in
        switch result {
        case .success(let movies):
          self.movies = movies
          self.stopSpinner()
			case .failure:
          // Hanle errors
          print("Errors")
        }
      }
    }
    
  }
  
  // MARK: - Functions
  
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellId",
                                             for: indexPath) as! MovieCell
    
    cell.titleLabel.text = movies[indexPath.row].title
        cell.year.text = movies[indexPath.row].year
        if let url = URL(string: movies[indexPath.row].imageURL) {
          cell.poster.kf.setImage(with: url)
        }
    return cell
  }
  
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
   func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      var textBefore = searchBar.text!
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

