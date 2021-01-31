//
//  ViewController.swift
//  Esay - Movie App
//
//  Created by admin on 16.12.2020.
//  Copyright © 2020 esaygiver. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    var popularMovies = [Movie]()
    var trendingMovies = [Movie]()
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        searchPopularMovies()
        searchTrendingMovies()
  //      getsPopularMovies()
        
    }
}

extension ViewController {
    func getsPopularMovies() {
        networkManager.fetchPopularMovies { (result) in
            
            print(result)
//            switch result {
//            case .success(let popularMovies):
//                self.popularMovies = popularMovies
//
//            case .failure:
//                print("We got an issue!")
//            }
        }
    }
}

//MARK: - TableView DataSource and Delegate methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: popularMovies[indexPath.row])
        cell.addingShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPopularMovie = popularMovies[indexPath.row]
        
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailViewController.movie = selectedPopularMovie
        
        self.show(detailViewController, sender: self)
        
    }
    
}


//MARK: - CollectionView DataSource, Flowlayout and Delegate methods

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let selectedCell = trendingMovies[indexPath.row]
        cell.configureTrends(with: selectedCell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - Popular Movies Request
extension ViewController {
    func searchPopularMovies() {
        PopularRepository.getPopularMovies(successHandler: popularListSuccessHandler(responseModel:), failureHandler: popularListFailureHandler(errorMessage:))
    }

    func popularListSuccessHandler(responseModel: DataResults) {
        if responseModel != nil {
            self.popularMovies.append(contentsOf: responseModel.movies)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            print("sıçtık")
        }
    }

    func popularListFailureHandler(errorMessage: String) {
        print(errorMessage)
    }

}

//MARK: - Trend Movies Request
extension ViewController {
    func searchTrendingMovies() {
        TrendRepository.getTrends(successHandler: trendingListSuccessHandler(responseModel:), failureHandler: trendingListFailureHandler(errorMessage:))
    }
    func trendingListSuccessHandler(responseModel: DataResults) {
        if responseModel != nil {
            self.trendingMovies.append(contentsOf: responseModel.movies)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func trendingListFailureHandler(errorMessage: String) {
        print(errorMessage)
    }
}

