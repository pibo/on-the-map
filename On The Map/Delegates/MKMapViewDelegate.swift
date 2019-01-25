//
//  MKMapViewDelegate.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 23/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    
    // MARK: Properties
    
    var myStudentAnnotation: StudentAnnotation?
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "StudentLocationPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.clusteringIdentifier = reuseIdentifier
        annotationView!.canShowCallout = true
        annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        // Set the color for markers and clusters.
        if let cluster = annotation as? MKClusterAnnotation {
            annotationView!.markerTintColor = UIColor(named: "Darker Blue")!
            
            if let myAnnotation = myStudentAnnotation, let memberAnnotations = cluster.memberAnnotations as? [StudentAnnotation], memberAnnotations.contains(myAnnotation) {
                annotationView!.markerTintColor = UIColor(named: "Primary Red")!
            }
        } else {
            annotationView!.markerTintColor = (annotation as! StudentAnnotation).markColor
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let mediaURL = (view.annotation as? StudentAnnotation)?.studentLocation.mediaURL {
                UIApplication.shared.open(URL(string: mediaURL)!, options: [:], completionHandler: nil)
            }
        }
    }
}
