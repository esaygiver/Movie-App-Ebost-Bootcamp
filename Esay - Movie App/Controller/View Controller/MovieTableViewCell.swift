
//
//  MovieTableViewCell.swift
//  Esay - Movie App
//
//  Created by admin on 16.12.2020.
//  Copyright © 2020 esaygiver. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var moviePosterImage: UIImageView!
    @IBOutlet var movieReleaseDate: UILabel!
    @IBOutlet var shadowLayerOfCell: UIImageView!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet var movieOverview: UILabel! {
        didSet {
            movieOverview.numberOfLines = 3
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.title
        self.movieOverview.text = model.overview
        self.moviePosterImage.fetchImage(from: model.posterURL.absoluteString)
        self.movieReleaseDate.text = model.releaseDate
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

extension MovieTableViewCell {
    func addingShadow() {
        shadowLayerOfCell.layer.masksToBounds = false
        shadowLayerOfCell.layer.shadowColor = UIColor.gray.cgColor
        shadowLayerOfCell.layer.shadowOffset = CGSize(width: 0, height: 7.0)
        shadowLayerOfCell.layer.shadowRadius = 5.0
        shadowLayerOfCell.layer.shadowOpacity = 0.75

    }
}
