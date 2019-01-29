//
//  StudentLocation.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreLocation

struct StudentLocation: Codable, Equatable {
    
    // MARK: Properties
    
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    
    var objectId: String?
    var latitude: Double?
    var longitude: Double?
    
    // MARK: Computed Properties
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // MARK: Initializer
    
    init(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        uniqueKey = (try? container.decode(String.self, forKey: .uniqueKey)) ?? ""
        firstName = (try? container.decode(String.self, forKey: .firstName)) ?? ""
        lastName  = (try? container.decode(String.self, forKey: .lastName))  ?? ""
        mapString = (try? container.decode(String.self, forKey: .mapString)) ?? ""
        mediaURL  = (try? container.decode(String.self, forKey: .mediaURL))  ?? ""
        objectId = try container.decode(String.self, forKey: .objectId)
        latitude = try? container.decode(Double.self, forKey: .latitude)
        longitude = try? container.decode(Double.self, forKey: .longitude)
    }
    
    // MARK: Methods
    
    mutating func getCoordinate(completionHandler: @escaping ((latitude: Double, longitude: Double)?, Error?) -> Void) {
        if let lat = latitude, let lon = longitude {
            completionHandler((latitude: lat, longitude: lon), nil)
            return
        }
        
        CLGeocoder().geocodeAddressString(mapString) { placemarks, error in
            if let error = error {
                
                // Check if no results were found or if we have another type of error.
                if (error as NSError).code == CLError.Code.geocodeFoundNoResult.rawValue {
                    completionHandler(nil, nil)
                } else {
                    completionHandler(nil, error)
                }
                
                return
            }
            
            let location = placemarks?.first?.location
            
            if let location = location {
                let coordinate = location.coordinate
                completionHandler((latitude: coordinate.latitude, longitude: coordinate.longitude), nil)
            } else {
                completionHandler(nil, nil)
            }
        }
    }
}

extension StudentLocation {
    static func ==(lhs: StudentLocation, rhs: StudentLocation) -> Bool {
        return lhs.objectId == rhs.objectId
    }
}
