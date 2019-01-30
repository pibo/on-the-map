//
//  NewStudentLocationViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 22/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class NewStudentLocationViewController: KeyboardAwareViewController, HideViewsOnLandscape {
    
    // MARK: - Properties
    
    var newStudentLocation: StudentLocation!
    
    // MARK: - Outlets
    
    @IBOutlet var mapStringTextField: UITextField!
    @IBOutlet var mediaURLTextField: UITextField!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var globeImage: UIImageView!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustView(for: [mapStringTextField, mediaURLTextField])
        hideKeyboardOnTap()
        hideOnLandscape(view: globeImage)
        setupRoundedBorders()
    }
    
    // MARK: - Methods
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        hideOnLandscape(view: globeImage, transitioningTo: newCollection)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewStudentLocationMap" {
            let destination = segue.destination as! NewStudentLocationMapViewController
            destination.newStudentLocation = newStudentLocation
        }
    }
    
    func setupRoundedBorders() {
        mapStringTextField.padding(left: 4, right: 4)
        mapStringTextField.borderStyle = .roundedRect
        
        mediaURLTextField.padding(left: 4, right: 4)
        mediaURLTextField.borderStyle = .roundedRect
        
        continueButton.cornerRadius(4)
    }
    
    func isLoading(_ loading: Bool) {
        if loading {
            continueButton.isHidden = true
            activityIndicator.startAnimating()
        } else {
            continueButton.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
    
    func handleGetCoordinateCompletion(coordinate: (latitude: Double, longitude: Double)?, error: Error?) {
        isLoading(false)
        
        if let error = error {
            handleGetCoordinateError(error: error)
        } else if let coordinate = coordinate {
            handleGetCoordinateSuccess(coordinate: coordinate)
        } else {
            handleGetCoordinateNotFound()
        }
    }
    
    func handleGetCoordinateError(error: Error) {
        let alert = UIAlertController(title: Strings.Error.title, message: Strings.Error.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func handleGetCoordinateSuccess(coordinate: (latitude: Double, longitude: Double)) {
        newStudentLocation.latitude = coordinate.latitude
        newStudentLocation.longitude = coordinate.longitude
        
        performSegue(withIdentifier: "NewStudentLocationMap", sender: self)
    }
    
    func handleGetCoordinateNotFound() {
        let alert = UIAlertController(
            title: Strings.NewStudentLocationNotFound.title,
            message: Strings.NewStudentLocationNotFound.message(mapStringTextField.text!),
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            self.mapStringTextField.text = ""
            self.mapStringTextField.becomeFirstResponder()
        }
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueToMap(_ sender: Any) {
        isLoading(true)
        
        let user = DataController.shared.user!
        newStudentLocation = StudentLocation(
            uniqueKey: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
            mapString: mapStringTextField.text!,
            mediaURL: mediaURLTextField.text!
        )
        
        newStudentLocation.getCoordinate(completion: handleGetCoordinateCompletion(coordinate:error:))
    }
}

// MARK: - UITextFieldDelegate

extension NewStudentLocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mapStringTextField:
            mediaURLTextField.becomeFirstResponder()
        case mediaURLTextField:
            continueToMap(textField)
        default: break
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text! as NSString
        textField.text = currentText.replacingCharacters(in: range, with: string)
        continueButton.enabled(!mapStringTextField.text!.isEmpty && !mediaURLTextField.text!.isEmpty)
        return false
    }
}
