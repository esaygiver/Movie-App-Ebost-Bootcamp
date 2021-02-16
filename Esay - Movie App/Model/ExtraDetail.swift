//
//  ExtraDetail.swift
//  Esay - Movie App
//
//  Created by admin on 13.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation

class ExtraDetail: Codable {
    let runtime: Int
    
    enum CodingKeys: String, CodingKey {
        case runtime = "runtime"
    }
}
