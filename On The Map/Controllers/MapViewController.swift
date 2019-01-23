//
//  MapViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: InternalViewController {
    
    // MARK: Properties
    
    let delegate = MapViewDelegate()
    
    // MARK: Outlets
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = delegate
        addAnnotations()
    }
    
    // MARK: Notification Related Methods
    
    override func dataContainerDidChange(_ notification: Notification) {
        removeAnnotations()
        addAnnotations()
    }
    
    // MARK: Methods
    
    func addAnnotations() {
        let studentLocations = DataContainer.shared.studentLocations
        let annotations = studentLocations.reversed().map(StudentLocationMKPointAnnotation.init)
        
        mapView.addAnnotations(annotations)
    }
    
    func removeAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
}
