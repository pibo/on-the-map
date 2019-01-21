//
//  InternalViewController.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 21/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import UIKit

class InternalViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var refreshButtonItem: UIBarButtonItem!
    @IBOutlet var addButtonItem: UIBarButtonItem!
    
    // MARK: Refresh Related Methods
    
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
        let alert = UIAlertController(title: "Error", message: "An error occurred when refreshing. Please try again in a moment!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out? You have to provide an e-mail and password to sign in again.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOut = UIAlertAction(title: "Sign Out", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        alert.addAction(signOut)
        
        present(alert, animated: true, completion: nil)
    }
}
