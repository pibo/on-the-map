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
        
        // MARK: - Properties
        
        static let signUp = URL(string: "https://auth.udacity.com/sign-up")!
        static let session = url("/session")
        
        // MARK: - Methods
        
        static func users(id: String) -> URL { return url("/users/\(id)") }
    }
}
