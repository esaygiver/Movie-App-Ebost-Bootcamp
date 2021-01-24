//
//  CastCollectionViewCell.swift
//  Esay - Movie App
//
//  Created by admin on 23.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var castImage: UIImageView!
    @IBOutlet var castName: UILabel!
    
    func configureCast(model: ResultsForCast) {
        self.castName.text = model.name
        let url = "https://image.tmdb.org/t/p/w500\((model.profile_path ?? "fl1Jt9brtTV6vfNl5mv55SrSCZm.jpg")!)"
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.castImage.image = UIImage(data: data)
        }
    }
}
