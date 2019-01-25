//
//  StudentAnnotation.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

class StudentAnnotation: MKPointAnnotation {
    
    // MARK: Properties
    
    let studentLocation: StudentLocation
    let markColor: UIColor
    
    var memberAnnotations: [MKAnnotation] = []
    
    // MARK: Initializer
    
    init(studentLocation: StudentLocation, markColor: UIColor) {
        self.studentLocation = studentLocation
        self.markColor = markColor
        
        super.init()
        
        let latitude = CLLocationDegrees(studentLocation.latitude!)
        let longitude = CLLocationDegrees(studentLocation.longitude!)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        title = studentLocation.fullName
        subtitle = studentLocation.mediaURL
    }
}
