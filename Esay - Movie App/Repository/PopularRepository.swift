//
//  PopularRepository.swift
//  Esay - Movie App
//
//  Created by admin on 28.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Alamofire

class PopularRepository {
    static func getPopularMovies(successHandler: @escaping successHandler<PopularMovies>, failureHandler: @escaping failureHandler ) {
    let popularMovieURL = "https:api.themoviedb.org/3/movie/popular?api_key=660a71826e07d00e08b7baa0a340d61b&language=en-US&page=1"
    AF.request(popularMovieURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
        
        guard let data = responseData.data else { return }
        if (responseData.response?.statusCode == 200) {
            do {
                var resultForPopularMovies: PopularMovies? = try JSONDecoder().decode(PopularMovies.self, from: data)
                successHandler(resultForPopularMovies!)
            } catch {
                failureHandler("Parsing error!")
            }
        } else {
            failureHandler("Network error!")
            }
        }
    }
}
