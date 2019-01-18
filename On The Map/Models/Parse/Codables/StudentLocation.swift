//
//  StudentLocation.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 18/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    
    var objectId: String?
    var latitude: Float?
    var longitude: Float?
}
