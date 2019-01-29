//
//  ParseEndpoints.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Parse {
    
    struct Endpoints {
        
        // MARK: - Properties
        
        static let studentLocation = url("/StudentLocation")
        
        // MARK: - Methods
        
        static func studentLocation(limit: Int, skip: Int, order: String?) -> URL {
            var params: [String: String] = [:]
            
            params["limit"] = String(limit)
            params["skip"] = String(skip)
            
            if let order = order {
                params["order"] = order
            }
            
            return url("/StudentLocation", params: params)
        }
        
        static func studentLocation(where query: String) -> URL {
            return url("/StudentLocation", params: ["where": query])
        }
        
        static func studentLocation(id: String) -> URL {
            return url("/StudentLocation/\(id)")
        }
    }
}
