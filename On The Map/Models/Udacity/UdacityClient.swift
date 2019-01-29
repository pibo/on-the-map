//
//  Client.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 17/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

class Udacity: URLBuilder {
    
    // MARK: - Properties
    
    static let scheme: String = "https"
    static let host: String = "onthemap-api.udacity.com"
    static let path: String? = "/v1"
    
    static let api: API = {
	    var api = API()
	    api.transformData = { data in data.subdata(in: 5..<data.count) }
	    return api
    }()
}
