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
        } else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.clusteringIdentifier = reuseIdentifier
        annotationView!.canShowCallout = true
        annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        // Always use purple for clusters.
        if annotation is MKClusterAnnotation {
            annotationView!.markerTintColor = .purple
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
