//
//  MovieData.swift
//  Esay - Movie App
//
//  Created by admin on 16.12.2020.
//  Copyright © 2020 esaygiver. All rights reserved.
//

import UIKit

// these two for popular part
struct PopularMovies: Codable {
    let results: [ResultsForPopularMovies]
}
struct ResultsForPopularMovies: Codable {
    let title: String
    let poster_path: String
    let release_date: String
    let overview: String
    let id: Int
    let backdrop_path: String
}

