//
//  CastData.swift
//  Esay - Movie App
//
//  Created by admin on 23.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

struct CastResponseModel: Codable {
    let cast: [Cast]
}
struct Cast: Codable {
    let profile_path: String?
    let name: String?
    
    var profileURL: URL {
        return URL(string: "\(getURL(on: .castProfileURL))\(profile_path ?? "")")!
    }
}
