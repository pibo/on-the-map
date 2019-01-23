//
//  MKMapViewDelegate.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 23/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "StudentLocationPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView!.canShowCallout = true
            annotationView!.markerTintColor = UIColor(named: "Primary Blue")
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        let studentLocation = (annotation as? StudentLocationMKPointAnnotation)?.source
        if let studentLocation = studentLocation, let myLocation = DataContainer.shared.myStudentLocation, myLocation == studentLocation {
            annotationView!.markerTintColor = .red
        }
        
        // Always use orange for clusters.
        if annotation is MKClusterAnnotation {
            annotationView!.markerTintColor = .purple
        }
        
        annotationView!.clusteringIdentifier = reuseIdentifier
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let mediaURL = view.annotation?.subtitle! {
                UIApplication.shared.open(URL(string: mediaURL)!, options: [:], completionHandler: nil)
            }
        }
    }
}
