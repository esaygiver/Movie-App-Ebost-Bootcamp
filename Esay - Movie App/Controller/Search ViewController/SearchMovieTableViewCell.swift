//
//  SearchMovieTableViewCell.swift
//  Esay - Movie App
//
//  Created by admin on 14.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet var movieOverview: UILabel! {
        didSet {
            movieOverview.numberOfLines = 4
        }
    }
    
    
    func configureTrends(with model: Movie) {
        self.movieTitleLabel.text = model.title
        self.movieImage.fetchImage(from: model.posterURL.absoluteString)
        self.movieReleaseDate.text = model.releaseDate
        self.movieOverview.text = model.overview
        
        switch Int(model.rate) {
        case 8...10:
            movieRate.text = "\(String(model.rate)) ⭐️⭐️⭐️⭐️⭐️"
        case 6...8:
            movieRate.text = "\(String(model.rate)) ⭐️⭐️⭐️⭐️"
        case 4...6:
            movieRate.text = "\(String(model.rate)) ⭐️⭐️⭐️"
        case 2...4:
            movieRate.text = "\(String(model.rate)) ⭐️⭐️"
        case 1...2:
            movieRate.text = "\(String(model.rate)) ⭐️"
        default:
            movieRate.text = "No rate given"
        }
    }

}
