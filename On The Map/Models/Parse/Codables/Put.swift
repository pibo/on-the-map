//
//  Put.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Parse {
    
    // MARK: - Response
    
    struct PutResponse: Decodable {
        
        // MARK: - Properties
        
        let updatedAt: String
    }
}
