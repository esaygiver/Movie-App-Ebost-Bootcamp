//
//  OpeningScreen.swift
//  Esay - Movie App
//
//  Created by admin on 17.12.2020.
//  Copyright © 2020 esaygiver. All rights reserved.
//
//
import UIKit

class OpeningScreenViewController: UIViewController {
    
    @IBOutlet weak var popcornImage: UIImageView!
    @IBOutlet weak var findYourMovieButton: UIButton!
    
  //  @IBOutlet weak var checkListButton: UIButton!
    override func viewDidLoad() {
           super.viewDidLoad()

        findYourMovieButton.layer.cornerRadius = findYourMovieButton.frame.size.height / 2
//        checkListButton.layer.cornerRadius = checkListButton.frame.size.height / 2
        
    }
}
