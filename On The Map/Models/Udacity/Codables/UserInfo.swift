//
//  UserInfo.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
    
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
        let user = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
        let email = try user.nestedContainer(keyedBy: CodingKeys.self, forKey: .email)
        
        id = try user.decode(String.self, forKey: .id)
        firstName = try user.decode(String.self, forKey: .firstName)
        lastName = try user.decode(String.self, forKey: .lastName)
        nickname = try user.decode(String.self, forKey: .nickname)
        self.email = try email.decode(String.self, forKey: .address)
    }
    
    // MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname, email, user, address
    }
}
