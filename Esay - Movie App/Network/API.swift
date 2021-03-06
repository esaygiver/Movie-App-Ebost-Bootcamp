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
    case video(movieID: Int)
    case review(movieID: Int)
    case runtime(movieID: Int)
    case search(query: String)
    

}

fileprivate let APIKey = getURL(on: .APIKey)

extension MovieAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: getURL(on: .baseURL)) else { fatalError() }
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
        case .video(movieID: let movieID):
            return "movie/\(movieID)/videos"
        case .review(movieID: let movieID):
            return "movie/\(movieID)/reviews"
        case .search(_):
            return "search/movie"
        case .runtime(movieID: let movieID):
            return "movie/\(movieID)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .popular, .trends, .cast(_), .video(_), .review(_), .search(_), .runtime(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular, .trends, .cast, .video(_), .review(_), .runtime(_):
            return .requestParameters(parameters: ["api_key" : APIKey], encoding: URLEncoding.queryString)
        case .search(query: let query):
            return .requestParameters(parameters: ["api_key" : APIKey, "query": query], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

