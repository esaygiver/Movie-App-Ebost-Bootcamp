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
    
    var provider = MoyaProvider<MovieAPI>(plugins: [NetworkLoggerPlugin()])
    
    func fetchPopularMovies(completion: @escaping ([Movie]) -> ()) {
        provider.request(.popular) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(DataResults.self, from: response.data)
                    completion(results.movies)
                } catch let error {
                    dump(error)
                }
            case let .failure(error):
                dump(error)
            }
        }
    }
    
    func fetchTrendingMovies(completion: @escaping ([Movie]) -> ()) {
        provider.request(.trends) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(DataResults.self, from: response.data)
                    completion(results.movies)
                } catch let error {
                    dump(error)
                }
            case let .failure(error):
                dump(error)
            }
        }
    }
    
    func fetchCast(movieID: Int, completion: @escaping ([Cast]) -> ()) {
        provider.request(.cast(movieID: movieID)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(CastResponseModel.self, from: response.data)
                    completion(results.cast)
                } catch let error {
                    dump(error)
                }
            case let .failure(error):
                dump(error)
            }
        }
    }
}






//private extension NetworkManager {
//    private func request<T: Codable>(target: API, completion: @escaping ([Movie]) -> ()) {
//        provider.request(target) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(T.self, from: response.data)
//                    completion(.success(results))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
//}