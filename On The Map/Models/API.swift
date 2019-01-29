//
//  API.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 14/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

class API {
    
    // MARK: - Properties

    var defaultHeaders: [String: String] = [
        "Accept": "application/json",
        "Content-Type": "application/json",
    ]
    
    var transformData: (Data) -> Data = { $0 }
    
    // MARK: - Method Enum
    
    enum Method: String {
        case GET, POST, PUT, DELETE
    }
    
    // MARK: - Methods
    
    private func request<Request: Encodable, Response: Decodable>(method: Method, url: URL, payload: Request?, decodable: Response.Type, headers: [String: String], completion: @escaping (Response?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = defaultHeaders.merging(headers, uniquingKeysWith: { $1 })
        
        // Check if there is a payload.
        if let payload = payload {
	        request.httpBody = try! JSONEncoder().encode(payload)
		}
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            let transformedData = self.transformData(data)
            let decoder = JSONDecoder()
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, !(200...299).contains(statusCode) {
                DispatchQueue.main.async { completion(nil, APIError(status: statusCode)) }
                return
            }
            
            do {
                let decoded = try decoder.decode(Response.self, from: transformedData)
                DispatchQueue.main.async { completion(decoded, nil) }
            } catch {
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
        
        task.resume()
        
        return task
    }
    
    // MARK: - Convenience Methods
    
    func get<Response: Decodable>(url: URL, decodable: Response.Type, headers: [String: String] = [:], completion: @escaping (Response?, Error?) -> Void) -> URLSessionDataTask {
        return request(method: .GET, url: url, payload: nil as String?, decodable: Response.self, headers: headers, completion: completion)
    }
    
    func post<Request: Encodable, Response: Decodable>(url: URL, payload: Request, decodable: Response.Type, headers: [String: String] = [:], completion: @escaping (Response?, Error?) -> Void) -> URLSessionDataTask {
        return request(method: .POST, url: url, payload: payload, decodable: Response.self, headers: headers, completion: completion)
    }
    
    func put<Request: Encodable, Response: Decodable>(url: URL, payload: Request, decodable: Response.Type, headers: [String: String] = [:], completion: @escaping (Response?, Error?) -> Void) -> URLSessionDataTask {
        return request(method: .PUT, url: url, payload: payload, decodable: Response.self, headers: headers, completion: completion)
    }
    
    func delete<Response: Decodable>(url: URL, decodable: Response.Type, headers: [String: String] = [:], completion: @escaping (Response?, Error?) -> Void) -> URLSessionDataTask {
        return request(method: .DELETE, url: url, payload: nil as String?, decodable: Response.self, headers: headers, completion: completion)
    }
}

struct APIError: Error {
    let status: Int
}
