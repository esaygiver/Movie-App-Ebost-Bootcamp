//
//  API.swift
//  Esay - Movie App
//
//  Created by admin on 29.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation
import Moya

enum API {
    case popularMovies
}

var APIKey: String = "?api_key=660a71826e07d00e08b7baa0a340d61b&language=en-US&page=1"

extension API: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https:api.themoviedb.org/3/") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "movie/popular\(APIKey)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .popularMovies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popularMovies:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

