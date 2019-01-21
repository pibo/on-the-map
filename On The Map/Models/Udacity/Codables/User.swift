//
//  User.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    // MARK: Properties
    
    let id: String
    let firstName: String
    let lastName: String
    let nickname: String
    let email: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // MARK: Initializer
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let email = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .email)
        
        id = try container.decode(String.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        nickname = try container.decode(String.self, forKey: .nickname)
        self.email = try email.decode(String.self, forKey: .address)
    }
    
    // MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname, email, address
    }
}
