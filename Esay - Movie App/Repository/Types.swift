//
//  Types.swift
//  Esay - Movie App
//
//  Created by admin on 28.01.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation

typealias successHandler<T> =  (_ responseModel: T) -> ()
typealias failureHandler = (_ errorMessage: String) -> ()
