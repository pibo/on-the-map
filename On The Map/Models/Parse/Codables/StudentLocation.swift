//
//  StudentLocation.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreLocation

struct StudentLocation: Codable {
    
    // MARK: Properties
    
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    
    var objectId: String?
    var latitude: Double?
    var longitude: Double?
    
    // MARK: Methods
    
    mutating func getCoordinate(completionHandler: @escaping ((latitude: Double, longitude: Double)?, Error?) -> Void) {
        if let lat = latitude, let lon = longitude {
            completionHandler((latitude: lat, longitude: lon), nil)
            return
        }
        
        CLGeocoder().geocodeAddressString(mapString) { placemarks, error in
            if let error = error {
                completionHandler(nil, error)
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
