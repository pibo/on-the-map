//
//  Convenience.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 17/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Udacity {
    
    class func login(username: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        let payload = LoginRequest(username: username, password: password)
        let _ = api.post(url: Endpoints.session, payload: payload, decodable: LoginResponse.self) { response, error in
            if let response = response, response.success {
                completionHandler(response.id, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    class func logout(completionHandler: @escaping (Error?) -> Void) {
        var headers: [String: String] = [:]
        let xsrfCookie = HTTPCookieStorage.shared.cookies!.first(where: { $0.name == "XSRF-TOKEN" })
        
        if let xsrfCookie = xsrfCookie { headers["X-XSRF-TOKEN"] = xsrfCookie.value }
        
        let _ = api.delete(url: Endpoints.session, decodable: LogoutResponse.self, headers: headers) { response, error in
            if response != nil { completionHandler(nil) }
            else { completionHandler(error) }
        }
    }
    
    class func getUserInfo(id: String, completionHandler: @escaping (UserInfo?, Error?) -> Void) {
        let _ = api.get(url: Udacity.Endpoints.users(id: id), decodable: UserInfo.self) { response, error in
            if let response = response {
                completionHandler(response, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
