//
//  CastData.swift
//  Esay - Movie App
//
//  Created by admin on 23.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

struct Cast: Codable {
    let profilePath: String?
    let name: String?
    let id: Int?
    
    var profileURL: URL {
        return URL(string: "\(getURL(on: .castProfileURL))\(profilePath ?? "")")!
    }
    
    private enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path", name, id
    }
}

struct CastResponseModel: Codable {
    let cast: [Cast]
}
