//
//  FavoriteMoviesViewController.swift
//  Esay - Movie App
//
//  Created by admin on 11.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Moya

class FavoriteMoviesViewController: UIViewController {

    var favoriteMovies = [String]()
    var movieText = ""
    @IBOutlet var tableView: UITableView!
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        print(movieText)
        getsPopularMovies()
    }
    
    @IBActionb func didTapRefresh() {
        NotificationCenter.default.post(name: Notification.Name("favoriteMovies"), object: favoriteMovies)
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let selectedCell = favoriteMovies[indexPath.row]
        cell.textLabel?.text = selectedCell.title
        cell.detailTextLabel?.text = String(selectedCell.rate)
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        cell.accessoryType = cell.isSelected ? .checkmark : .none

    }
}

//extension FavoriteMoviesViewController {
//func getsPopularMovies() {
//    networkManager.fetchPopularMovies { [weak self] movies in
//        self?.favoriteMovies = movies
//        DispatchQueue.main.async {
//            self?.tableView.reloadData()
//        }
//    }
//}
//}
