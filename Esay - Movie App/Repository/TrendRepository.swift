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
    static func getTrends(successHandler: @escaping successHandler<DataResults>, failureHandler: @escaping failureHandler) {
        AF.request(getURL(on: .trendingMoviesURL), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            guard let data = responseData.data else { return }
            if (responseData.response?.statusCode == 200) {
                do {
                    let resultForTrendingMovies: DataResults? = try JSONDecoder().decode(DataResults.self, from: data)
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
