//
//  DetailViewController.swift
//  Esay - Movie App
//
//  Created by admin on 22.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieOverview: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    var cast = [ResultsForCast]()
    
    var movieTitleInFirstVC = ""
    var movieOverviewInFirstVC = ""
    var movieImageInFirstVC: UIImage!
    var movieID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movieTitleInFirstVC
        movieOverview.text = movieOverviewInFirstVC
        movieImage.image = movieImageInFirstVC
        searchCast()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - ColelctionView Delegate and DataSource Methods

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        let myCell = cast[indexPath.row]
        cell.configureCast(model: myCell)
        return cell
    }
}

extension DetailViewController {
    func searchCast() {
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=660a71826e07d00e08b7baa0a340d61b&language=en-US", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            guard let data = responseData.data else {
                print("We got an error about responsing Data")
                return
            }
            print(self.movieID)
            var resultForCast: Casts?
            do {
                resultForCast = try JSONDecoder().decode(Casts.self, from: data)
            } catch {
                print(error)
            }
            guard let finalResult = resultForCast else { return }
            print(finalResult.cast.first?.name)
            let newCasts = finalResult.cast
            self.cast.append(contentsOf: newCasts)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}


