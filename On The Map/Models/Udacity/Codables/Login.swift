//
//  Requests.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 17/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Udacity {

    // MARK: - Request
    
    struct LoginRequest: Encodable {
        
        // MARK: - Properties
        
        private let credentials: Credentials
        
        // MARK: - Initializer
        
        init(username: String, password: String) {
            self.credentials = Credentials(username: username, password: password)
        }
        
        private struct Credentials: Encodable {
            let username: String
            let password: String
        }
        
        // MARK: - CodingKeys
        
        enum CodingKeys: String, CodingKey {
            case credentials = "udacity"
        }
    }
    
    // MARK: - Response
    
    struct LoginResponse: Decodable {
        
        // MARK: - Properties
        
        let id: String
        let success: Bool
        let sessionID: String
        
        // MARK: - Initializer
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let account = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .account)
            let session = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .session)
            
            id = try account.decode(String.self, forKey: .id)
            success = try account.decode(Bool.self, forKey: .success)
            sessionID = try session.decode(String.self, forKey: .sessionID)
        }
        
        // MARK: - CodingKeys
        
        enum CodingKeys: String, CodingKey {
            case account
            case session
            case id = "key"
            case success = "registered"
            case sessionID = "id"
        }
    }
}
