//
//  MovieCollectionViewCell.swift
//  Esay - Movie App
//
//  Created by admin on 19.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
        
    func configureTrends(with model: ResultsForTrendingMovies) {
        self.movieTitleLabel.text = model.title
        let url = "https://image.tmdb.org/t/p/w500\(model.backdrop_path)"
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.movieImage.image = UIImage(data: data)
        }
    }
}

extension MovieCollectionViewCell {
    func shadowAndRounded() {
        
        let radius: CGFloat = 20
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}


