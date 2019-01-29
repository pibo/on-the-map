//
//  Results.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Parse {
    
    // MARK: - Response
    
    struct ResultsResponse: Decodable {
        
        // MARK: - Properties
        
        let results: [StudentLocation]
    }
}
