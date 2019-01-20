//
//  Logout.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Udacity {
    
    // MARK: Response
    
    struct LogoutResponse: Decodable {
        
        // MARK: Properties
        
        let sessionID: String
        
        // MARK: Initializer
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let session = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .session)
            
            sessionID = try session.decode(String.self, forKey: .sessionID)
        }
        
        // MARK: CodingKeys
        
        enum CodingKeys: String, CodingKey {
            case session
            case sessionID = "id"
        }
    }
}
