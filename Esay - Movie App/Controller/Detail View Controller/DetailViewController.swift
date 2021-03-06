//
//  DetailViewController.swift
//  Esay - Movie App
//
//  Created by admin on 22.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Moya
import SafariServices

class DetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieOverview: UITextView!
    @IBOutlet var movieVote: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var trailerAndReviewButton: UIButton!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet weak var castCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var embeddedVCHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    
    
    //  var favoriteMovieArray = [String]()
    var networkManager = NetworkManager()
    fileprivate var cast = [Cast]()
    public var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        castCollectionViewHeightConstraint.constant = 0
        embeddedVCHeight.constant = 0
        scrollHeight.constant = 665
        updatingOutlets()
        getCast()
        getCurvyButton(trailerAndReviewButton)
        
    }
    //MARK: - Embedding ExtraDetailVC to DetailVC part
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToExtraDetailVC" {
            let destinationVC = segue.destination as! ExtraDetailViewController
            destinationVC.movie = movie
        }
    }
    
//    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
//        if favoriteButton.tintColor == .lightGray {
//            favoriteButton.tintColor = .yellow
//            //            NotificationCenter.default.post(name: Notification.Name("favoriteMovies"), object: movieTitle.text)
//            //    favoriteMovieArray.append(movieTitle.text!)
//            //   print(favoriteMovieArray)
//        } else {
//            favoriteButton.tintColor = .lightGray
//            //         favoriteMovieArray.removeLast()
//            //          print(favoriteMovieArray)
//        }
//  }
    
    
    
    @IBAction func trailerAndReviewButtonTapped(_ sender: UIButton) {
        if embeddedVCHeight.constant == 0 {
            scrollHeight.constant = 1300
            embeddedVCHeight.constant = 635
        } else {
            embeddedVCHeight.constant = 0
            scrollHeight.constant = 665
        }
    }
}

//MARK: - Network Request
extension DetailViewController {
    func getCast() {
        networkManager.fetchCast(movieID: self.movie.id ?? 399566) { [weak self] casts in
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
        releaseDate.text = self.movie.releaseDate
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectedCastID = cast[indexPath.row].id
        let url = "\(getURL(on: .castTMDBPage))\(selectedCastID ?? 12345)"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
}
//MARK: - Button with curves and shadows
extension DetailViewController {
    func getCurvyButton(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.size.height / 2
    }
}


