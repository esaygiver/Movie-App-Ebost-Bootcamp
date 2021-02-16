//
//  Favorites.swift
//  Esay - Movie App
//
//  Created by admin on 15.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation
import RealmSwift

class Favorites: Object {
    @objc dynamic var MovieTitle: String = ""
    @objc dynamic var MovieRate: String = ""
}
