//
//  StudentAnnotation.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

class StudentAnnotation: NSObject, MKAnnotation {
    
    // MARK: - Properties
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let studentLocation: StudentLocation
    let markColor: UIColor
    
    var memberAnnotations: [MKAnnotation] = []
    
    // MARK: - Initializer

    init(studentLocation: StudentLocation, markColor: UIColor) {
        self.studentLocation = studentLocation
        self.markColor = markColor

        let latitude = CLLocationDegrees(studentLocation.latitude!)
        let longitude = CLLocationDegrees(studentLocation.longitude!)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        title = studentLocation.fullName
        subtitle = studentLocation.mediaURL
    }
}

// MARK: - Equatable for StudentAnnotation

func ==<T: StudentAnnotation>(lhs: T, rhs: T) -> Bool {
    return lhs.studentLocation == rhs.studentLocation
}
