//
//  MovieData.swift
//  Esay - Movie App
//
//  Created by admin on 16.12.2020.
//  Copyright © 2020 esaygiver. All rights reserved.
//

import UIKit

struct Movie: Codable {

    let title: String?
    let posterPath: String?
    let releaseDate: String
    let overview: String?
    let id: Int
    let backDrop: String?
    let rate: Double
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath ?? "")")!
    }
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backDrop ?? "")")!
    }
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path", backDrop = "backdrop_path", rate = "vote_average", releaseDate = "release_date", title, overview, id
    }
}

