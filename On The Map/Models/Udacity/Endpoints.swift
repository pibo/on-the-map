//
//  Endpoints.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 17/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Udacity {
    
    struct Endpoints {
        static let session = Udacity.url("/session")
        static func users(id: Int) -> URL { return Udacity.url("/users/" + String(id)) }
    }
}
