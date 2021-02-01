//
//  KeyValue.swift
//  Esay - Movie App
//
//  Created by admin on 1.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation

enum URLs: String, CaseIterable {
        case popularMoviesURL
        case trendingMoviesURL
        case imageURL
        case castProfileURL
    }
 
func getURL(on platform: URLs) -> String {
    let apiKey = "api_key=660a71826e07d00e08b7baa0a340d61b&language=en-US&page=1"
    let baseURL = "https://api.themoviedb.org/3/"
        switch platform {
        case .popularMoviesURL:
            return "\(baseURL)movie/popular?\(apiKey)"
        case .trendingMoviesURL:
            return "\(baseURL)trending/movie/day?\(apiKey)"
        case .imageURL:
            return "https://image.tmdb.org/t/p/original"
        case .castProfileURL:
            return "https://image.tmdb.org/t/p/w500"
        }
    return platform.rawValue
    }


