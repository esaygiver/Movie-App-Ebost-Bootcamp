//
//  ViewController.swift
//  Esay - Movie App
//
//  Created by admin on 16.12.2020.
//  Copyright © 2020 esaygiver. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    var popularMovies = [ResultsForPopularMovies]()
    var trendingMovies = [ResultsForTrendingMovies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchPopularMovies()
        searchTrendingMovies()
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        let myData = popularMovies[indexPath.row]
        
        let movieTitle = myData.title
        let movieOverview = myData.overview
        let movieId = myData.id
        let url = "https://image.tmdb.org/t/p/w500\(myData.poster_path)"
        guard let data = try? Data(contentsOf: URL(string: url)!) else { return }
        let movieImage = UIImage(data: data)
        let newVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        newVC.movieImageInFirstVC = movieImage
        newVC.movieOverviewInFirstVC = movieOverview
        newVC.movieTitleInFirstVC = movieTitle
        newVC.movieID = movieId
        
        self.show(newVC, sender: self)
    
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
        let myCell = trendingMovies[indexPath.row]
        cell.configureTrends(with: myCell)
        cell.shadowAndRounded()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let myData = trendingMovies[indexPath.row]
//        let url = "https://image.tmdb.org/t/p/w185\(myData.backdrop_path)"
//        guard let data = try? Data(contentsOf: URL(string: url)!) else { return }
//        let movieImage = UIImage(data: data)
//        let newVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//
//        newVC.movieImageInFirstVC = movieImage
//        self.show(newVC, sender: self)
        
    }
}

//MARK: - Popular Movies Request

extension ViewController {
    func searchPopularMovies() {
        AF.request("https:api.themoviedb.org/3/movie/popular?api_key=660a71826e07d00e08b7baa0a340d61b&language=en-US&page=1", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            guard let data = responseData.data else {
                print("We got an error about responsing Data")
                return
            }
            var resultForPopularMovies: PopularMovies?
            do {
                resultForPopularMovies = try JSONDecoder().decode(PopularMovies.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            guard let finalResult = resultForPopularMovies else { return }
            let newPopularMovies = finalResult.results
            self.popularMovies.append(contentsOf: newPopularMovies)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - Trend Movies Request
extension ViewController {
    func searchTrendingMovies() {
        AF.request("https://api.themoviedb.org/3/trending/movie/day?api_key=660a71826e07d00e08b7baa0a340d61b", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            guard let data = responseData.data else { return }
            var resultForTrendingMovies: TrendingMovies?
            do {
                resultForTrendingMovies = try JSONDecoder().decode(TrendingMovies.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            guard let lastResult = resultForTrendingMovies else { return }
            let newTrendingMovies = lastResult.results
            print(newTrendingMovies.first?.title)
            self.trendingMovies.append(contentsOf: newTrendingMovies)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


