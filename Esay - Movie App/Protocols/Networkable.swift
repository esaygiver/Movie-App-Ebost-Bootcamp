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
    var provider: MoyaProvider<API> { get }
    func fetchPopularMovies(completion: @escaping (Result<Movie, Error>) -> () )
}
