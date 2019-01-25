//
//  NewStudentLocationMapViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 22/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import MapKit
import UIKit

class NewStudentLocationMapViewController: UIViewController {
    
    // MARK: Properties
    
    let delegate = MapViewDelegate()
    var annotation: StudentAnnotation!
    var newStudentLocation: StudentLocation!
    var originalButtonTitle: String!
    

    // MARK: Outlets
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var finishButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the button.
        finishButton.setTitle("", for: .disabled)
        finishButton.cornerRadius(4)
        
        // Configure the mapView.
        mapView.delegate = delegate
        addAnnotation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.showAnnotations([annotation], animated: true)
    }

    // MARK: Methods

    func addAnnotation() {
        annotation = StudentAnnotation(studentLocation: newStudentLocation, markColor: UIColor(named: "Primary Red")!)
        mapView.addAnnotation(annotation)
    }

    func isLoading(_ loading: Bool) {
        if loading {
            finishButton.isEnabled = false
            activityIndicator.startAnimating()
        } else {
            finishButton.isEnabled = true
            activityIndicator.stopAnimating()
        }
    }
    
    func handleError(error: Error) {
        let alert = UIAlertController(title: Strings.Error.title, message: Strings.Error.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func handlePostResponse(id: String?, error: Error?) {
        isLoading(false)
        
        if let error = error {
            handleError(error: error)
            return
        }
        
        newStudentLocation.objectId = id!
        DataContainer.shared.myStudentLocation = newStudentLocation
        dismiss(animated: true, completion: nil)
    }
    
    func handlePutResponse(error: Error?) {
        isLoading(false)
        
        if let error = error {
            handleError(error: error)
            return
        }
        
        DataContainer.shared.myStudentLocation = newStudentLocation
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions

    @IBAction func finish(_ sender: Any) {
        isLoading(true)
        
        if let myLocation = DataContainer.shared.myStudentLocation {
            Parse.put(id: myLocation.objectId!, payload: newStudentLocation, completionHandler: handlePutResponse(error:))
        } else {
            Parse.post(newStudentLocation, completionHandler: handlePostResponse(id:error:))
        }
    }
}
