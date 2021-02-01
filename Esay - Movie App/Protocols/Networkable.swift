//
//  Networkable.swift
//  Esay - Movie App
//
//  Created by admin on 31.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<MovieAPI> { get }
    func fetchPopularMovies(completion: @escaping ([Movie]) -> () )
    func fetchTrendingMovies(completion: @escaping ([Movie]) -> () )
    func fetchCast(movieID: Int, completion: @escaping ([Cast]) -> () )
    
}
