//
//  URLBuilder.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 17/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

protocol URLBuilder {
    
    // MARK: - Required Properties
    
    static var scheme: String { get }
    static var host: String { get }
    static var path: String? { get }
    
    static func url(_ path: String?, params: [String: String]) -> URL
}

extension URLBuilder {
    
    // MARK: - Default Implementation
    
    static func url(_ path: String? = nil, params: [String: String] = [:]) -> URL {
        var components = URLComponents()
        components.scheme = Self.scheme
        components.host = Self.host
        components.path = (Self.path ?? "") + (path ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value)
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}
