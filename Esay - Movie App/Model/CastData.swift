//
//  CastData.swift
//  Esay - Movie App
//
//  Created by admin on 23.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

struct Casts: Codable {
    let cast: [ResultsForCast]
}
struct ResultsForCast: Codable {
    let profile_path: String?
    let name: String?
}
