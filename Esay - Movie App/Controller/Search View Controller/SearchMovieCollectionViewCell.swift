//
//  SearchMovieCollectionViewCell.swift
//  Esay - Movie App
//
//  Created by admin on 10.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class SearchMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    func configureTrends(with model: Movie) {
        self.movieTitleLabel.text = model.title
        self.movieImage.fetchImage(from: model.posterURL.absoluteString ?? "")
    }
}
