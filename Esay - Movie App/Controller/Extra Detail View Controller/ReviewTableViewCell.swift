//
//  ReviewTableViewCell.swift
//  Esay - Movie App
//
//  Created by admin on 2.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewerUserName: UILabel!
    @IBOutlet weak var reviewRate: UILabel!
    @IBOutlet weak var review: UITextView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func configureReviews(model: Review) {

            switch Int(model.authorDetails.rating ?? 0) {
            case 8...10:
                reviewRate.text = "⭐️⭐️⭐️⭐️⭐️"
            case 6...8:
                reviewRate.text = "⭐️⭐️⭐️⭐️"
            case 4...6:
                reviewRate.text = "⭐️⭐️⭐️"
            case 2...4:
                reviewRate.text = "⭐️⭐️"
            case 1...2:
                reviewRate.text = "⭐️"
            default:
                reviewRate.text = "No rate given"
            }
            
            reviewerUserName.text = model.authorDetails.userName
            review.text = model.content
        }
    }

