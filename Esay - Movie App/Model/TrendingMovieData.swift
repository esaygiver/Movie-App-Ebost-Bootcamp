//
//  TrendingMovieData.swift
//  Esay - Movie App
//
//  Created by admin on 19.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

// these two for trending part
struct TrendingMovies: Codable {
    let results: [Results]
}
struct Results: Codable {
    let title: String?
    let backdrop_path: String?
    let id: Int?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdrop_path ?? "")")!
    }
}
