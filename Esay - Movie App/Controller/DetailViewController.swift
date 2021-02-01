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
    @IBOutlet var movieOverview: UITextView!
    @IBOutlet var movieVote: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var castCollectionViewHeightConstraint: NSLayoutConstraint!
    var networkManager = NetworkManager()
    
    fileprivate var cast = [Cast]()
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        castCollectionViewHeightConstraint.constant = 0
        updatingOutlets()
//        searchCast()
        getCast()
        
    }
}

extension DetailViewController {
    func getCast() {
        networkManager.fetchCast(movieID: self.movie.id) { [weak self] casts in
            self?.cast = casts
            DispatchQueue.main.async {
                self?.castCollectionViewHeightConstraint.constant = 170
                self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: - Updating Outlets
extension DetailViewController {
    func updatingOutlets() {
        movieTitle.text = self.movie.title
        movieOverview.text = self.movie.overview
        movieVote.text = String(self.movie.rate)
        movieImage.fetchImage(from: movie.backdropURL.absoluteString)
    }
}

//MARK: - CollectionView Delegate and DataSource Methods
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        let myCell = cast[indexPath.row]
        cell.configureCast(model: myCell)
        return cell
    }
}

//extension DetailViewController {
//    func searchCast() {
//        CastRepository.getCast(movieID: self.movie.id, successHandler: castListSuccessHandler(responseModel:), failureHandler: castListFailureHandler(errorMessage:))
//    }
//
//    func castListSuccessHandler(responseModel: CastResponseModel) {
//        if (!responseModel.cast.isEmpty || responseModel.cast != nil) {
//            self.cast.append(contentsOf: responseModel.cast)
//            castCollectionViewHeightConstraint.constant = 170
//            self.collectionView.reloadData()
//        }
//    }
//
//    func castListFailureHandler(errorMessage: String) {
//        print(errorMessage)
//    }
//}


