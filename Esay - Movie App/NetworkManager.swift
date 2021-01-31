//
//  NetworkManager.swift
//  Esay - Movie App
//
//  Created by admin on 29.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation
import Moya

class NetworkManager: Networkable {
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func fetchPopularMovies(completion: @escaping (Result<Movie, Error>) -> ()) {
        request(target: .popularMovies, completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Codable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
