//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

extension Parse {
    
    class func get(limit: Int = 100, skip: Int = 0, order: String? = "-createdAt", completion: @escaping ([StudentLocation]?, Error?) -> Void) {
        let url = Endpoints.studentLocation(limit: limit, skip: skip, order: order)
        let _ = api.get(url: url, decodable: ResultsResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func get(id: String, completion: @escaping (StudentLocation?, Error?) -> Void) {
        let url = Endpoints.studentLocation(where: "{\"uniqueKey\": \"\(id)\"}")
        let _ = api.get(url: url, decodable: ResultsResponse.self) { response, error in
            if let response = response {
                completion(response.results.first, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func post(_ payload: StudentLocation, completion: @escaping (String?, Error?) -> Void) {
        let _ = api.post(url: Endpoints.studentLocation, payload: payload, decodable: PostResponse.self) { response, error in
            if let response = response {
                completion(response.objectId, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func put(id: String, payload: StudentLocation, completion: @escaping (Error?) -> Void) {
        let url = Endpoints.studentLocation(id: id)
        let _ = api.put(url: url, payload: payload, decodable: PutResponse.self) { response, error in
            if response != nil {
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
}
