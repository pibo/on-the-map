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
    
    // MARK: - Properties
    
    var delegate = MapViewDelegate()
    var otherStudentAnnotations = [StudentAnnotation]()
    var myStudentAnnotation: StudentAnnotation?
    
    // MARK: - Outlets
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = delegate
        
        let controller = DataController.shared
        
        if let myLocation = controller.myStudentLocation {
            let annotation = StudentAnnotation(studentLocation: myLocation, markColor: UIColor(named: "Primary Red")!)
            add(my: annotation)
        }
        
        let annotations = controller.otherStudentLocations.map { StudentAnnotation(studentLocation: $0, markColor: UIColor(named: "Primary Blue")!) }
        add(other: annotations)
    }
    
    // MARK: - Notification Related Methods
    
    @objc override func didChangeOtherStudentLocations(_ notification: Notification) {
        let otherStudentLocations = notification.userInfo![DataController.otherStudentLocationsKey] as! [StudentLocation]
        
        mapView.removeAnnotations(otherStudentAnnotations)
        
        let annotations = otherStudentLocations.map { StudentAnnotation(studentLocation: $0, markColor: UIColor(named: "Primary Blue")!) }
        add(other: annotations)
    }
    
    @objc override func didAddMyStudentLocation(_ notification: Notification) {
        let myStudentLocation = notification.userInfo![DataController.myStudentLocationKey] as! StudentLocation
        let annotation = StudentAnnotation(studentLocation: myStudentLocation, markColor: UIColor(named: "Primary Red")!)
        
        add(my: annotation)
    }
    
    @objc override func didUpdateMyStudentLocation(_ notification: Notification) {
        let myStudentLocation = notification.userInfo![DataController.myStudentLocationKey] as! StudentLocation
        
        mapView.removeAnnotation(myStudentAnnotation!)
        
        let annotation = StudentAnnotation(studentLocation: myStudentLocation, markColor: UIColor(named: "Primary Red")!)
        add(my: annotation)
    }
    
    // MARK: - Methods
    
    func add(my annotation: StudentAnnotation) {
        delegate.myStudentAnnotation = annotation
        myStudentAnnotation = annotation
        mapView.addAnnotation(annotation)
    }
    
    func add(other annotations: [StudentAnnotation]) {
        otherStudentAnnotations = annotations
        mapView.addAnnotations(annotations)
    }
}
