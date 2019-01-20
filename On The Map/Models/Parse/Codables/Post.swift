//
//  Post.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Parse {
    
    // MARK: Response
    
    struct PostResponse: Decodable {
        
        // MARK: Properties
        
        let objectId: String
    }
}
