//
//  CastRepository.swift
//  Esay - Movie App
//
//  Created by admin on 26.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Alamofire

class CastRepository {
    static func getCast(movieID: Int, successHandler: @escaping successHandler<CastResponseModel> ,  failureHandler: @escaping (_ errorMessage: String) -> () ) {
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=660a71826e07d00e08b7baa0a340d61b&language=en-US", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (responseData) in
            
            if (responseData.response?.statusCode == 200) {
                do {
                    var resultForCast: CastResponseModel? = try JSONDecoder().decode(CastResponseModel.self, from: responseData.data!)
                    successHandler(resultForCast!)
                } catch {
                    failureHandler("parsing error")
                }
            } else {
                failureHandler("network error")
            }
        }
    }
}
