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
    static func getPopularMovies(successHandler: @escaping successHandler<DataResults>, failureHandler: @escaping failureHandler ) {
        
        AF.request(getURL(on: .popularMoviesURL), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
        
        guard let data = responseData.data else { return }
        if (responseData.response?.statusCode == 200) {
            do {
                var resultForPopularMovies: DataResults? = try JSONDecoder().decode(DataResults.self, from: data)
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
