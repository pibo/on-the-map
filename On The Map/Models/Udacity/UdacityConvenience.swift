//
//  Convenience.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 17/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Udacity {
    
    class func signIn(username: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        let payload = LoginRequest(username: username, password: password)
        let _ = api.post(url: Endpoints.session, payload: payload, decodable: LoginResponse.self) { response, error in
            if let response = response, response.success {
                completion(response.id, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func signOut(completion: @escaping (Error?) -> Void) {
        var headers: [String: String] = [:]
        let xsrfCookie = HTTPCookieStorage.shared.cookies!.first(where: { $0.name == "XSRF-TOKEN" })
        
        if let xsrfCookie = xsrfCookie { headers["X-XSRF-TOKEN"] = xsrfCookie.value }
        
        let _ = api.delete(url: Endpoints.session, decodable: LogoutResponse.self, headers: headers) { response, error in
            if response != nil { completion(nil) }
            else { completion(error) }
        }
    }
    
    class func getUser(id: String, completion: @escaping (User?, Error?) -> Void) {
        let _ = api.get(url: Udacity.Endpoints.users(id: id), decodable: User.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
