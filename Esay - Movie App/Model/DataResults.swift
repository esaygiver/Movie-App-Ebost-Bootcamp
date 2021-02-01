//
//  DataResults.swift
//  Esay - Movie App
//
//  Created by admin on 31.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

struct DataResults: Codable {
    let page: Int
//    let numResults: Int
//    let numpages: Int
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results", page
    }
}
