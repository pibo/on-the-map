//
//  InternalViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class InternalViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var refreshButtonItem: UIBarButtonItem!
    @IBOutlet var addButtonItem: UIBarButtonItem!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe(to: DataController.shared)
    }
    
    deinit {
        unsubscribe(from: DataController.shared)
    }
    
    // MARK: - Notification Related Methods
    
    @objc func didChangeOtherStudentLocations(_ notification: Notification) {}
    @objc func didAddMyStudentLocation(_ notification: Notification) {}
    @objc func didUpdateMyStudentLocation(_ notification: Notification) {}
    
    func subscribe(to container: DataController) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeOtherStudentLocations(_:)),
            name: DataController.didChangeOtherStudentLocationsNotification,
            object: container
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didAddMyStudentLocation(_:)),
            name: DataController.didAddMyStudentLocationNotification,
            object: container
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateMyStudentLocation(_:)),
            name: DataController.didUpdateMyStudentLocationNotification,
            object: container
        )
    }
    
    func unsubscribe(from container: DataController) {
        NotificationCenter.default.removeObserver(
            self,
            name: DataController.didChangeOtherStudentLocationsNotification,
            object: container
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: DataController.didAddMyStudentLocationNotification,
            object: container
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: DataController.didUpdateMyStudentLocationNotification,
            object: container
        )
    }
    
    // MARK: - Refresh Related Methods
    
    func isRefreshing(_ refreshing: Bool) {
        if refreshing {
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            let activityIndicatorBarItem = UIBarButtonItem(customView: activityIndicator)
            
            navigationItem.setRightBarButtonItems([addButtonItem, activityIndicatorBarItem], animated: true)
            
            activityIndicator.color = .gray
            activityIndicator.startAnimating()
        } else {
            navigationItem.setRightBarButtonItems([addButtonItem, refreshButtonItem], animated: true)
        }
    }
    
    func displayRefreshErrorAlert() {
        let alert = UIAlertController(title: Strings.RefreshFailed.title, message: Strings.RefreshFailed.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: Strings.SignOut.title, message: Strings.SignOut.message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOut = UIAlertAction(title: "Sign Out", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        alert.addAction(signOut)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refresh(_ sender: Any) {
        isRefreshing(true)
        DataController.shared.refresh { error in
            self.isRefreshing(false)
            if error != nil { self.displayRefreshErrorAlert() }
        }
    }
    
    @IBAction func newStudentLocation(_ sender: Any) {
        if DataController.shared.myStudentLocation == nil {
            performSegue(withIdentifier: "NewStudentLocation", sender: self)
        } else {
            let alert = UIAlertController(title: Strings.NewStudentLocationOverwrite.title, message: Strings.NewStudentLocationOverwrite.message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let overwrite = UIAlertAction(title: "Overwrite", style: .destructive) { _ in
                self.performSegue(withIdentifier: "NewStudentLocation", sender: self)
            }
            
            alert.addAction(cancel)
            alert.addAction(overwrite)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
