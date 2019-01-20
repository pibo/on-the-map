//
//  Client.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

class Parse: URLBuilder {
    
    // MARK: Properties
    
    static let scheme: String = "https"
    static let host: String = "parse.udacity.com"
    static let path: String? = "/parse/classes"
    
    static let authHeaders = [
        "X-Parse-Application-Id": "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr",
        "X-Parse-REST-API-Key": "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY",
    ]
 
    static let api: API = {
        var api = API()
        api.defaultHeaders.merge(authHeaders, uniquingKeysWith: { $1 })
        return api
    }()
}
