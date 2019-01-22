//
//  StudentLocationMKPointAnnotation.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

class StudentLocationMKPointAnnotation: MKPointAnnotation {
    
    // MARK: Initializer
    
    init(_ studentLocation: StudentLocation) {
        super.init()
        
        let latitude = CLLocationDegrees(studentLocation.latitude!)
        let longitude = CLLocationDegrees(studentLocation.longitude!)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        title = studentLocation.fullName
        subtitle = studentLocation.mediaURL
    }
}
