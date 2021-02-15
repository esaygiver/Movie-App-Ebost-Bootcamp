//
//  SearchViewController.swift
//  Esay - Movie App
//
//  Created by admin on 9.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var networkManager = NetworkManager()
    var movie = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
    }
}

//MARK: - SearchBar Delegate and Network Request
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.movie = []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text else { return }
        if !query.isEmpty {
            fetchMovies(query: query)
        } else {
            self.movie = []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Network Request
extension SearchViewController {
    func fetchMovies(query: String) {
        networkManager.searchMovies(query: query) { [weak self] (results) in
            self?.movie = results
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - Search TableView Part
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell") as! SearchMovieTableViewCell
        let selectedCell = movie[indexPath.row]
        cell.configureTrends(with: selectedCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchedMovies = movie[indexPath.row]
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.movie = searchedMovies
        self.show(detailViewController, sender: self)
        
    }
    
    
}
