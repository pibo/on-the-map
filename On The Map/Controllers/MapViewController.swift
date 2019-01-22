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
    
    // MARK: Outlets
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnnotations()
    }
    
    // MARK: Methods
    
    func addAnnotations() {
        let studentLocations = DataContainer.shared.studentLocations
        let annotations = studentLocations.map(StudentLocationMKPointAnnotation.init)
        
        mapView.addAnnotations(annotations)
    }

    // MARK: Actions
    
    @IBAction func refresh(_ sender: Any) {
        isRefreshing(true)
        DataContainer.shared.refresh { error in
            self.isRefreshing(false)
            if error != nil { self.displayRefreshErrorAlert() }
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.addAnnotations()
        }
    }
}

// MARK: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "StudentLocationPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView!.canShowCallout = true
            annotationView!.markerTintColor = UIColor(named: "Primary Blue")!
            annotationView!.clusteringIdentifier = reuseIdentifier
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
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
