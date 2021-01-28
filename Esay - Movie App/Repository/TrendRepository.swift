//
//  TrendRepository.swift
//  Esay - Movie App
//
//  Created by admin on 28.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation
import Alamofire

class TrendRepository {
    static func getTrends(successHandler: @escaping successHandler<TrendingMovies>, failureHandler: @escaping failureHandler) {
        let trendsURL = "https://api.themoviedb.org/3/trending/movie/day?api_key=660a71826e07d00e08b7baa0a340d61b"
        AF.request(trendsURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            guard let data = responseData.data else { return }
            if (responseData.response?.statusCode == 200) {
                do {
                    var resultForTrendingMovies: TrendingMovies? = try JSONDecoder().decode(TrendingMovies.self, from: data)
                    successHandler(resultForTrendingMovies!)
                } catch {
                    failureHandler("parsing error at trending movies!")
                }
            } else {
                failureHandler("network error at trending movies request!")
            }
        }
    }
}
