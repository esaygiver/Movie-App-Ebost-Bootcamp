//
//  API.swift
//  Esay - Movie App
//
//  Created by admin on 29.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation
import Moya

enum MovieAPI {
    case popular
    case trends
    case cast(movieID: Int)
}

let APIKey = "660a71826e07d00e08b7baa0a340d61b"

extension MovieAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .trends:
            return "trending/movie/day"
        case .cast(movieID: let movieID):
            return "movie/\(movieID)/credits"
        }
    }
    var method: Moya.Method {
        switch self {
        case .popular, .trends, .cast:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular, .trends, .cast:
            return .requestParameters(parameters: ["api_key" : APIKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

